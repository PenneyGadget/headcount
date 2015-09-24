require 'economic_profile'
require 'csv'

class District

  def initialize(district)
    @district = district
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
    EconomicProfile.new
  end

end
