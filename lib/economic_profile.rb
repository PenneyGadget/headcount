class EconomicProfile
  attr_accessor :district_data, :economic_profile_data

  def initialize(district_data)
    @district_data = district_data
    @economic_profile_data = district_data.select { |k, v| k == "Median household income" ||
                                                           k == "School-aged children in poverty" ||
                                                           k == "Students qualifying for free or reduced price lunch" ||
                                                           k == "Title I students" }
  end

  def free_or_reduced_lunch_in_year(year)
    frl = economic_profile_data.select { |k, v| k == "Students qualifying for free or reduced price lunch" }
    frl_data = frl["Students qualifying for free or reduced price lunch"]
    frl_year = frl_data.find_all { |hash| hash[:poverty_level] == "Eligible for Free or Reduced Lunch" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent"}
    frl_float = frl_year[0][:data].to_f.round(3)
  end

end
