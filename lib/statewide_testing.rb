require 'pry'

class StatewideTesting
  attr_accessor :district_data, :statewide_testing_data

  def initialize(district_data)
    @district_data = district_data
    @statewide_testing_data = district_data.select { |k, v| k == "3rd grade students scoring proficient or above on the CSAP_TCAP" ||
                                                           k == "8th grade students scoring proficient or above on the CSAP_TCAP" ||
                                                           k == "Average proficiency on the CSAP_TCAP by race_ethnicity_Math" ||
                                                           k == "Average proficiency on the CSAP_TCAP by race_ethnicity_Reading" ||
                                                           k == "Average proficiency on the CSAP_TCAP by race_ethnicity_Writing" }
  end

  def proficient_by_grade(grade)
    # if not 3 or 8 for grade return error "UnknownDataError"
    pbg = statewide_testing_data.select { |k, v| k == "3rd grade students scoring proficient or above on the CSAP_TCAP" }
    pbg_data = pbg["3rd grade students scoring proficient or above on the CSAP_TCAP"]
    pbg_year = pbg_data.group_by { |hash| hash[:timeframe]}
    pbg_clean = pbg_year.each_value do |array|
      array.map! { |hash| hash = {hash[:score] => hash[:data]} }
    end
    hash = {}
    pbg_clean.each do |year, data|
      hash[year] ||= {}
      data.each do |subject_data|
        subject_data.each do |subject, score|
          hash[year][subject] ||= {}
          hash[year][subject] = score
        end
      end
    end
  end

  # def proficient_by_race_or_ethnicity(race)
  #   race_symbols = [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  #
  # end

end
