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
    @race_table = {asian: "Asian Students",
                   black: "Black Students",
                   pacific_islander: "Native Hawaiian or Other Pacific Islander",
                   hispanic: "Hispanic Students",
                   native_american: "Native American Students",
                   two_or_more: "Two or More Races",
                   white: "White Students"}
  end

  # receives integer, returns percentage of all students for a specific district
  def dropout_rate_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" } #all data with file name as key
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"] #just data hashes with files name key removed
    dropout_rate_select_data = dropout_rate_data.find_all { |hash| hash[:category] == "All Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    dropout_rate_float = dropout_rate_select_data[0][:data].to_f.round(3)
  end

  # receives integer, returns gender/percentage hash (how is district being addressed without hard coding?)
  def dropout_rate_by_gender_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    female = dropout_rate_data.find_all { |hash| hash[:category] == "Female Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    male = dropout_rate_data.find_all { |hash| hash[:category] == "Male Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    female_percent = female[0][:data].to_f.round(3)
    male_percent = male[0][:data].to_f.round(3)
    data = {female: female_percent, male: male_percent}
  end

  # receives integer, returns race/percentage hash ** how can I used a linked list here and use race_table as keys and data as values
  def dropout_rate_by_race_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    dropout_rate_select_data = dropout_rate_data.find_all { |hash| hash[:category] != "All Students" && hash[:category] != "Female Students" && hash[:category] != "Male Students" && hash[:timeframe] == "#{year}" }
    asian = dropout_rate_data.find_all { |hash| hash[:category] == "Asian Students" && hash[:timeframe] == "#{year}" && hash[:data] }
    asian_percent = asian[0][:data].to_f.round(3)
    black = dropout_rate_data.find_all { |hash| hash[:category] == "Black Students" && hash[:timeframe] == "#{year}" && hash[:data] }
    black_percent = black[0][:data].to_f.round(3)
    pacific_islander = dropout_rate_data.find_all { |hash| hash[:category] == "Native Hawaiian or Other Pacific Islander" && hash[:timeframe] == "#{year}" && hash[:data] }
    pacific_islander_percent = pacific_islander[0][:data].to_f.round(3)
    hispanic = dropout_rate_data.find_all { |hash| hash[:category] == "Hispanic Students" && hash[:timeframe] == "#{year}" && hash[:data] }
    hispanic_percent = hispanic[0][:data].to_f.round(3)
    native_american = dropout_rate_data.find_all { |hash| hash[:category] == "Native American Students" && hash[:timeframe] == "#{year}" && hash[:data] }
    native_american_percent = native_american[0][:data].to_f.round(3)
    two_or_more = dropout_rate_data.find_all { |hash| hash[:category] == "Two or More Races" && hash[:timeframe] == "#{year}" && hash[:data] }
    two_or_more_percent = two_or_more[0][:data].to_f.round(3)
    white = dropout_rate_data.find_all { |hash| hash[:category] == "White Students" && hash[:timeframe] == "#{year}" && hash[:data] }
    white_percent = white[0][:data].to_f.round(3)
    data = {asian: asian_percent, black: black_percent, pacific_islander: pacific_islander_percent, hispanic: hispanic_percent, native_american: native_american_percent, two_or_more: two_or_more_percent, white: white_percent}
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
    # asian_data = {}
    # asian.map! { |hash| asian_data.merge!({hash[:timeframe] => hash[:data]}) }

    binding.pry
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]

  end

  def graduation_rate_by_year

  end

  def graduation_rate_in_year(year)

  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)

  end

  def online_participation_by_year

  end

  def online_participation_in_year(year)

  end

  def participation_by_year

  end

  def participation_in_year(year)

  end

  def participation_by_race_or_ethinicity(race)

  end

  def participation_by_race_or_ethinicity_in_year(year)

  end

  def special_education_by_year

  end

  def special_education_in_year(year)

  end

  def remediation_by_year

  end

  def remediation_in_year(year)

  end

end
