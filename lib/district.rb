require_relative 'economic_profile'
require_relative 'enrollment'
require_relative 'statewide_testing'
require 'pry'

class District
  attr_accessor :district_data, :district_name

  def initialize(district_data, district_name)
    @district_data = district_data
    @district_name = district_name
  end

  def name
    district_name.upcase
  end

  def statewide_testing
    StatewideTesting.new(district_data)
  end

  def enrollment
    Enrollment.new(district_data)
  end

  def economic_profile
    EconomicProfile.new(district_data)
  end

end
