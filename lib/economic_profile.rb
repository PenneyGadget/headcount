class EconomicProfile
  attr_accessor :district_data, :economic_profile_data

  def initialize(district_data)
    @district_data = district_data
    @economic_profile_data = district_data.select { |k, v| k == "Median household income" ||
                                                           k == "School-aged children in poverty" ||
                                                           k == "Students qualifying for free or reduced price lunch" ||
                                                           k == "Title I students" }
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

  def free_or_reduced_lunch_by_year
    frl = economic_profile_data.select { |k, v| k == "Students qualifying for free or reduced price lunch" }
    frl_data = frl["Students qualifying for free or reduced price lunch"]
    frl_year = frl_data.find_all { |hash| hash[:poverty_level] == "Eligible for Free or Reduced Lunch" && hash[:dataformat] == "Percent"}
    frl_final_data = {}
    frl_year.each { |hash| frl_final_data.merge!({hash[:timeframe].to_i => ((hash[:data].to_f * 1000).to_i / 1000.0)}) }
    frl_final_data
  end

  def free_or_reduced_lunch_in_year(year)
    if (2000..2014).to_a.include?(year)
      frl = economic_profile_data.select { |k, v| k == "Students qualifying for free or reduced price lunch" }
      frl_data = frl["Students qualifying for free or reduced price lunch"]
      frl_year = frl_data.find_all { |hash| hash[:poverty_level] == "Eligible for Free or Reduced Lunch" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent"}
      frl_float = ((frl_year[0][:data]).to_f * 1000).to_i / 1000.0
    else
      return nil
    end
  end

  def school_aged_children_in_poverty_by_year
    sacp = economic_profile_data.select { |k, v| k == "School-aged children in poverty" }
    sacp_data = sacp["School-aged children in poverty"]
    if sacp_data.count > 0
      sacp_year = sacp_data.find_all { |hash| hash[:dataformat] == "Percent"}
      sacp_final_data = {}
      sacp_year.each { |hash| sacp_final_data.merge!({hash[:timeframe].to_i => hash[:data].to_f.round(3)}) }
      sacp_final_data
    else
      return {}
    end
  end

  def school_aged_children_in_poverty_in_year(year)
    sacp = economic_profile_data.select { |k, v| k == "School-aged children in poverty" }
    sacp_data = sacp["School-aged children in poverty"]
    if sacp_data.find { |hash| hash[:timeframe] == "#{year}" }.nil?
      return nil
    else
      sacp_year = sacp_data.find_all { |hash| hash[:dataformat] == "Percent" && hash[:timeframe] == "#{year}" && hash[:dataformat] == "Percent"}
      sacp_float = sacp_year[0][:data].to_f.round(3)
    end
  end

  def title_1_students_by_year
    tos = economic_profile_data.select { |k, v| k == "Title I students" }
    tos_data = tos["Title I students"]
    if tos_data.count > 0
      tos_final_data = {}
      tos_data.each { |hash| tos_final_data.merge!({hash[:timeframe].to_i => hash[:data].to_f.round(3)}) }
      tos_final_data
    else
      return {}
    end
  end

  def title_1_students_in_year(year)
    tos = economic_profile_data.select { |k, v| k == "Title I students" }
    tos_data = tos["Title I students"]
    if tos_data.find { |hash| hash[:timeframe] == "#{year}" }.nil?
      return nil
    else
      tos_year = tos_data.find_all { |hash| hash[:timeframe] == "#{year}"}
      tos_float = tos_year[0][:data].to_f.round(3)
    end
  end

end
