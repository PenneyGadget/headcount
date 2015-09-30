require 'pry'

class Enrollment
  attr_accessor :district_data, :enrollment_data, :race_table

  def initialize(district_data)
    @district_data = district_data
    @dropout_rate = district_data["Dropout rates by race and ethnicity"]
    @graduation_rate = district_data["High school graduation rates"]
    @kindergartners = district_data["Kindergartners in full-day program"]
    @online_enrollment = district_data["Online pupil enrollment"]
    @pupil_enrollment_race = district_data["Pupil enrollment by race_ethnicity"]
    @pupil_enrollment = district_data["Pupil enrollment"]
    @special_education = district_data["Special education"]
    @remediation = district_data["Remediation in higher education"]

    @race_table = {"Asian Students" => :asian,
                   "Black Students" => :black,
                   "Native Hawaiian or Other Pacific Islander" => :pacific_islander,
                   "Hispanic Students" => :hispanic,
                   "Native American Students" => :native_american,
                   "Two or More Races" => :two_or_more,
                   "White Students" => :white}
  end

  def truncate(number)
   (number.to_f * 1000).to_i / 1000.0
  end

  def valid_year?(year)
    years = []
    @district_data.each_value { |element| element.each { |x| years << x[:timeframe].to_i } }
    years.include? year
  end

  # receives integer, returns percentage of all students for a specific district
  def dropout_rate_in_year(year)
    if valid_year?(year)
      dropout_rate_select_data = @dropout_rate.find_all { |hash| hash[:category] == "All Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
      truncate(dropout_rate_select_data[0][:data])
    else
      nil
    end
  end

  # receives integer, returns gender/percentage hash (how is district being addressed without hard coding?)
  def dropout_rate_by_gender_in_year(year)
    female = @dropout_rate.find_all { |hash| hash[:category] == "Female Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    male = @dropout_rate.find_all { |hash| hash[:category] == "Male Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    data = {female: truncate(female[0][:data]), male: truncate(male[0][:data])}
  end

  # receives integer, returns race/percentage hash
  def dropout_rate_by_race_in_year(year)
    dropout_rate_select_data = @dropout_rate.find_all { |hash| hash[:category] != "All Students" && hash[:category] != "Female Students" && hash[:category] != "Male Students" && hash[:timeframe] == "#{year}" }
    race = dropout_rate_select_data.map { |hash| hash.fetch(:category) }
    data = dropout_rate_select_data.map { |hash| hash.fetch(:data) }
    dropout_rate = Hash[race.zip(data.map { |num| truncate(num) })]
    final_hash = Hash[dropout_rate.map { |k, v| [race_table[k], v] }]
  end

  # receives symbol, returns year/percentage hash
  def dropout_rate_for_race_or_ethnicity(race)
    category = @race_table.select {|k, v| k if v == race  }.keys
    @dropout_rate.select do |row|
      row[:category] == category.first
    end.map { |row| [row[:timeframe].to_i, truncate(row[:data])] }.to_h
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)

  end

  def graduation_rate_by_year

  end

  # receives integer, returns percentage of all students for a specific district
  def graduation_rate_in_year(year)
    graduation_rate_select_data = @graduation_rate.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(graduation_rate_select_data[0][:data])
  end

  def kindergarten_participation_by_year

  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_select_data = @kindergartners.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(kindergarten_participation_select_data[0][:data])
  end

  def online_participation_by_year

  end

  def online_participation_in_year(year)
    online_enrollment_select_data = @online_enrollment.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(online_enrollment_select_data[0][:data])
  end

  def participation_by_year

  end

  def participation_in_year(year)
    pupil_enrollment_select_data = @pupil_enrollment.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(pupil_enrollment_select_data[0][:data])
  end

  def participation_by_race_or_ethinicity(race)

  end

  def participation_by_race_or_ethinicity_in_year(year)

  end

  def special_education_by_year

  end

  def special_education_in_year(year)
    special_education_select_data = @special_education.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(special_education_select_data[0][:data])
  end

  def remediation_by_year

  end

  def remediation_in_year(year)
    pupil_enrollment_select_data = @remediation.find_all { |hash| hash[:timeframe] == "#{year}" && hash[:data] }
    truncate(pupil_enrollment_select_data[0][:data])
  end

end
