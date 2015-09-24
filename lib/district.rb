require_relative 'economic_profile'
require 'csv'

class District
  attr_accessor :district_data

  def initialize(district_data)
    @district_data = district_data
  end

  # def name
  #   # case insensitive - check on casing
  # end

  # def statewide_testing
  #   StatewideTesting.new
  # end
  #
  # def enrollment
  #   Enrollment.new
  # end
  #
  def economic_profile
    EconomicProfile.new(district_data)
  end

end
