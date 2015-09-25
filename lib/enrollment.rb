class Enrollment

  attr_accessor :district_data, :enrollment_data

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
end

  #receives an integer, returns percentage of all students for a specific district
  def dropout_rate_in_year(year)
    dropout_rate = enrollment_data.select { |k, v| k == "Dropout rates by race and ethnicity" }
    dropout_rate_data = dropout_rate["Dropout rates by race and ethnicity"]
    dropout_rate_year = dropout_rate_data.find_all { |hash| hash[:category] == "All Students" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent" }
    dropout_rate_float = dropout_rate_year[0][:data].to_f.round(3)
  end

end

# enrollment = Enrollment.new("ACADEMY 20")
# enrollment.dropout_rate_in_year(2012) # should equal 0.004
