class EconomicProfile
  attr_accessor :district_data, :economic_profile_data
  attr_reader :title_one_students, :school_children_poverty, :students_frl

  def initialize(district_data)
    @district_data = district_data
    @title_one_students = district_data["Title I students"]
    @school_children_poverty = district_data["School-aged children in poverty"]
    @students_frl = district_data["Students qualifying for free or reduced price lunch"]
  end

  def truncate(number)
    (number.to_f * 1000).to_i / 1000.0
  end

  def free_or_reduced_lunch_by_year
    students_frl.find_all { |hash| hash[:poverty_level] == "Eligible for Free or Reduced Lunch" && hash[:dataformat] == "Percent"}
    .map { |row| [row[:timeframe].to_i, truncate(row[:data])] }.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    free_or_reduced_lunch_by_year[year]
  end

  def school_aged_children_in_poverty_by_year
    school_children_poverty.find_all { |hash| hash[:dataformat] == "Percent"}
    .map { |row| [row[:timeframe].to_i, truncate(row[:data])] }.to_h
  end

  def school_aged_children_in_poverty_in_year(year)
    school_aged_children_in_poverty_by_year[year]
  end

  def title_1_students_by_year
    title_one_students.map do |row|
      [row[:timeframe].to_i, truncate(row[:data])]
    end.to_h
  end

  def title_1_students_in_year(year)
    title_1_students_by_year[year]
  end

end
