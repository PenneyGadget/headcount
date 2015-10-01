require 'pry'

class UnknownDataError < StandardError
end

class UnknownRaceError < StandardError
end

class StatewideTesting
  attr_accessor :district_data, :statewide_testing_data
  attr_reader :third_grade_scores, :eighth_grade_scores, :math_by_race, :reading_by_race, :writing_by_race

  def initialize(district_data)
    @district_data = district_data
    @third_grade_scores = district_data["3rd grade students scoring proficient or above on the CSAP_TCAP"]
    @eighth_grade_scores = district_data["8th grade students scoring proficient or above on the CSAP_TCAP"]
    @math_by_race = district_data["Average proficiency on the CSAP_TCAP by race_ethnicity_ Math"]
    @reading_by_race = district_data["Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading"]
    @writing_by_race = district_data["Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing"]

  @race_table = { "Asian" => :asian,
                  "Black" => :black,
                  "Hawaiian/Pacific Islander" => :pacific_islander,
                  "Hispanic" => :hispanic,
                  "Native American" => :native_american,
                  "Two or more" => :two_or_more,
                  "White" => :white
                }
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

  def valid_year?(year)
    years = []
    @district_data.each_value { |element| element.each { |x| years << x[:timeframe].to_i } }
    years.include? year
  end

  def valid_race?(race)
    @race_table.values.include?(race)
  end

  def proficient_by_grade(grade)
    if grade == 3
      tg = third_grade_scores.group_by { |hash| hash[:timeframe].to_i }.map { |k,v| [k,v] }.to_h
      tg.map { |k,v| [k, v.map { |h| [h[:score].downcase.to_sym, truncate(h[:data])] }.to_h] }.to_h
    elsif grade == 8
      eg = eighth_grade_scores.group_by { |hash| hash[:timeframe].to_i }.map { |k,v| [k,v] }.to_h
      eg.map { |k,v| [k, v.map { |h| [h[:score].downcase.to_sym, truncate(h[:data])] }.to_h] }.to_h
    else
      fail UnknownDataError
    end
  end

  # receives a symbol, returns a hash with years pointing at subject/integer hashes
  def proficient_by_race_or_ethnicity(race)
    fail UnknownRaceError unless valid_race?(race)
    eh = {}
    category = @race_table.select { |k, v| k if v == race }.keys
    math_by_race.find_all { |hash| hash[:race_ethnicity] == category.first }
      .each { |hash| eh[hash[:timeframe].to_i] = {:math => truncate(hash[:data])} }
    reading_by_race.find_all { |hash| hash[:race_ethnicity] == category.first }
      .each { |hash| eh[hash[:timeframe].to_i][:reading] = truncate(hash[:data]) }
    writing_by_race.find_all { |hash| hash[:race_ethnicity] == category.first }
      .each { |hash| eh[hash[:timeframe].to_i][:writing] = truncate(hash[:data]) }
    return eh
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    if !year.between?(2008,2014)
     raise UnknownDataError
    end
    if valid_year?(year) && (grade == 3 || grade == 8) && (subject == :math || subject == :writing || subject == :reading)
      proficient_by_grade(grade)[year][subject]
    else
      fail UnknownDataError
    end
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    if !year.between?(2011,2014)
      raise UnknownDataError
    end
    if valid_year?(year) && valid_race?(race) && (subject == :math || subject == :writing || subject == :reading)
      proficient_by_race_or_ethnicity(race)[year][subject]
    else
      fail UnknownDataError
    end
  end

  def proficient_for_subject_in_year(subject, year)
    if !year.between?(2011,2014)
      raise UnknownDataError
    end
    if valid_year?(year)
      if subject == :math
        m = math_by_race.find_all { |h| h[:race_ethnicity] == "All Students" && h[:timeframe] == "#{year}" }
        truncate(m[0][:data])
      elsif subject == :reading
        r = reading_by_race.find_all { |h| h[:race_ethnicity] == "All Students" && h[:timeframe] == "#{year}" }
        truncate(r[0][:data])
      elsif subject == :writing
        w = writing_by_race.find_all { |h| h[:race_ethnicity] == "All Students" && h[:timeframe] == "#{year}" }
        truncate(w[0][:data])
      else
        fail UnknownDataError
      end
    else
      fail UnknownDataError
    end
  end

end
