require 'pry'

class UnknownDataError < StandardError
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
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

  def proficient_by_grade(grade)
    if grade == 3
      tg = third_grade_scores.group_by { |hash| hash[:timeframe].to_i }.map { |k,v| [k,v] }.to_h
      tg.map { |k,v| [k, v.map { |h| [h[:score].downcase.to_sym, h[:data].to_f] }.to_h] }.to_h
    elsif grade == 8
      eg = eighth_grade_scores.group_by { |hash| hash[:timeframe].to_i }.map { |k,v| [k,v] }.to_h
      eg.map { |k,v| [k, v.map { |h| [h[:score].downcase.to_sym, h[:data].to_f] }.to_h] }.to_h
    else
      fail UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    race_symbols = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    # needs race to map to race map here, and take out asian hard coded
    eh = {}
    math_by_race.find_all { |hash| hash[:race_ethnicity] == "Asian" }
      .each { |hash| eh[hash[:timeframe].to_i] = {:math => truncate(hash[:data])} }
    reading_by_race.find_all { |hash| hash[:race_ethnicity] == "Asian" }
      .each { |hash| eh[hash[:timeframe].to_i][:reading] = truncate(hash[:data]) }
    writing_by_race.find_all { |hash| hash[:race_ethnicity] == "Asian" }
      .each { |hash| eh[hash[:timeframe].to_i][:writing] = truncate(hash[:data]) }
    eh
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    # needs some kind of parameter validation
    proficient_by_grade(grade)[year][subject]
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    # needs some kind of parameter validation
    proficient_by_race_or_ethnicity(race)[year][subject]
  end

  # still missing final/fifth method

end
