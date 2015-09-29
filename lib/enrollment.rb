require 'pry'

class Enrollment
  attr_accessor :district_data, :enrollment_data, :race_table

  def initialize(district_data)
    @district_data = district_data
    @enrollment_data = district_data.select { |k, v| k == "Dropout rates by race and ethnicity" ||
                                                     k == "High school graduation rates" ||
                                                     k == "Kindergartners in full-day program" ||
                                                     k == "Online pupil enrollment" ||
                                                     k == "Pupil enrollment by race_ethnicity" ||
                                                     k == "Pupil enrollment" ||
                                                     k == "Special education" ||
                                                     k == "Remediation in higher education" }
    @race_table = {"Asian Students" => :asian,
                   "Black Students" => :black,
                   "Native Hawaiian or Other Pacific Islander" => :pacific_islander,
                   "Hispanic Students" => :hispanic,
                   "Native American Students" => :native_american,
                   "Two or More Races" => :two_or_more,
                   "White Students" => :white}
  end

  # def truncate(number)
  #  (number.to_f * 1000).to_i / 1000.0
  # end

  # receives integer, returns percentage of all students for a specific district
  def dropout_rate_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" } #all data with file name as key
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"] #just data hashes with files name key removed
    dropout_rate_select_data = dropout_rate_data.find_all { |hash| hash[:category] == "All Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    dropout_rate_float = (dropout_rate_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  # receives integer, returns gender/percentage hash (how is district being addressed without hard coding?)
  def dropout_rate_by_gender_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    female = dropout_rate_data.find_all { |hash| hash[:category] == "Female Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    male = dropout_rate_data.find_all { |hash| hash[:category] == "Male Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    female_percent = (female[0][:data].to_f * 1000).to_i / 1000.0
    male_percent = (male[0][:data].to_f * 1000).to_i / 1000.0
    data = {female: female_percent, male: male_percent}
  end

  # receives integer, returns race/percentage hash
  def dropout_rate_by_race_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    dropout_rate_select_data = dropout_rate_data.find_all { |hash| hash[:category] != "All Students" && hash[:category] != "Female Students" && hash[:category] != "Male Students" && hash[:timeframe] == "#{year}" }
    race = dropout_rate_select_data.map { |hash| hash.fetch(:category) }
    data = dropout_rate_select_data.map { |hash| hash.fetch(:data) }
    formatted_data = data.map { |num| ((num.to_f * 1000).to_i / 1000.0) }
    dropout_rate = Hash[race.zip(formatted_data)]
    final_hash = Hash[dropout_rate.map { |k, v| [race_table[k], v] }]
  end

  # receives symbol, returns year/percentage hash
  def dropout_rate_for_race_or_ethnicity(race)
    race_id = ""
    if @race_table.has_key?(race)
      race_id = @race_table[race]
    end
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    dropout_rate_select_data = dropout_rate_data.find_all { |hash| hash[:category] != "All Students" && hash[:category] != "Female Students" && hash[:category] != "Male Students" && hash[:timeframe] && hash[:data] }
    asian = dropout_rate_select_data.map { |row| asian = row if row.values.include?("Asian Students") }.compact
    black = dropout_rate_select_data.map { |row| black = row if row.values.include?("Black Students") }.compact
    pacific_islander = dropout_rate_select_data.map { |row| pacific_islander = row if row.values.include?("Native Hawaiian or Other Pacific Islander") }.compact
    hispanic = dropout_rate_select_data.map { |row| hispanic = row if row.values.include?("Hispanic Students") }.compact
    native_american = dropout_rate_select_data.map { |row| native_american = row if row.values.include?("Native American Students") }.compact
    two_or_more = dropout_rate_select_data.map { |row| two_or_more = row if row.values.include?("Two or More Races") }.compact
    white = dropout_rate_select_data.map { |row| white = row if row.values.include?("White Students") }.compact
    binding.pry
    # asian_data = {}
    # asian.map! { |hash| asian_data.merge!({hash[:timeframe] => hash[:data]}) }
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]

  end

  def graduation_rate_by_year

  end

  # receives integer, returns percentage of all students for a specific district
  def graduation_rate_in_year(year)
    graduation_rate = enrollment_data.select { |k, v| k == "High school graduation rates" }
    graduation_rate_data = graduation_rate["High school graduation rates"]
    graduation_rate_select_data = graduation_rate_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    graduation_rate_float = (graduation_rate_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation = enrollment_data.select { |k, v| k == "Kindergartners in full-day program" }
    kindergarten_participation_data = kindergarten_participation["Kindergartners in full-day program"]
    kindergarten_participation_select_data = kindergarten_participation_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    kindergarten_participation_float = (kindergarten_participation_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  def online_participation_by_year

  end

  def online_participation_in_year(year)
    online_enrollment = enrollment_data.select { |k, v| k == "Online pupil enrollment" }
    online_enrollment_data = online_enrollment["Online pupil enrollment"]
    online_enrollment_select_data = online_enrollment_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    online_enrollment_float = (online_enrollment_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  def participation_by_year

  end

  def participation_in_year(year)
    pupil_enrollment = enrollment_data.select { |k, v| k == "Pupil enrollment" }
    pupil_enrollment_data = pupil_enrollment["Pupil enrollment"]
    pupil_enrollment_select_data = pupil_enrollment_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    pupil_enrollment_float = (pupil_enrollment_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  def participation_by_race_or_ethinicity(race)

  end

  def participation_by_race_or_ethinicity_in_year(year)

  end

  def special_education_by_year

  end

  def special_education_in_year(year)
    special_education = enrollment_data.select { |k, v| k == "Special education" }
    special_education_data = special_education["Special education"]
    special_education_select_data = special_education_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    special_education_float = (special_education_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

  def remediation_by_year

  end

  def remediation_in_year(year)
    pupil_enrollment = enrollment_data.select { |k, v| k == "Remediation in higher education" }
    pupil_enrollment_data = pupil_enrollment["Remediation in higher education"]
    pupil_enrollment_select_data = pupil_enrollment_data.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    pupil_enrollment_float = (pupil_enrollment_select_data[0][:data].to_f * 1000).to_i / 1000.0
  end

end
