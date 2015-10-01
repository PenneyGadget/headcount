require 'pry'                           # => true
require_relative 'district_repository'  # => true

class HeadcountAnalyst

  attr_accessor :district_repository  # => nil

  def initialize(district)
    @district = district    # => #<District:0x007f95937baa68 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"...
  end

  # def top_statewide_testing_year_over_year_growth(grade=nil, subject=nil, weighting=nil)
  #
  # end

  def kindergarten_participation_rate_average                     # ~> ArgumentError: wrong number of arguments (1 for 0)
    ha = @district.enrollment.kindergarten_participation_by_year
    ha_avg = ha.values.inject(:+) / ha.values.count
  end

  def kindergarten_participation_rate_variation(district, district_two)
    kindergarten_participation_rate_average(district)/kindergarten_participation_rate_average(district_two)
  end

  def kindergarten_participation_against_household_income(district)

  end

  def kindergarten_participation_correlates_with_household_income(district)

  end

  def kindergarten_participation_against_high_school_graduation(district)

  end

  def kindergarten_participation_correlates_with_high_school_graduation(district)

  end

end

path       = File.expand_path("../data", __dir__)                                                 # => "/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data"
repository = DistrictRepository.from_csv(path)                                                    # => #<DistrictRepository:0x007f9593189860 @path="/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data", @district_data=nil, @district_name=nil>
district   = repository.find_by_name("ACADEMY 20")                                                # => #<District:0x007f95937baa68 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :tim...
district_two   = repository.find_by_name("Colorado")                                              # => #<District:0x007f9596f99038 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"Colorado", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.697"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.691"}, {:location=>"Colorado", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.703"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.726"}, {:location=>"Colorado", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.698"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.501"}, {:location=>"Colorado", :score=>"Writing", :timeframe=>"2009", ...
HeadcountAnalyst.new(district).kindergarten_participation_rate_variation(district, district_two)

binding.pry

# ~> ArgumentError
# ~> wrong number of arguments (1 for 0)
# ~>
# ~> /Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/lib/headcount_analyst.rb:16:in `kindergarten_participation_rate_average'
# ~> /Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/lib/headcount_analyst.rb:22:in `kindergarten_participation_rate_variation'
# ~> /Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/lib/headcount_analyst.rb:47:in `<main>'
