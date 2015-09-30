require 'pry'                # => true
require_relative 'parse'     # => true
require_relative 'district'  # => true

class DistrictRepository
  attr_accessor :district_data, :path, :district_name  # => nil

  def initialize(path)
    @path = path                    # => "/Users/sekharpaladugu/code/projects/headcount/data"
    @district_data = district_data  # => nil
    @district_name = district_name  # => nil
  end                               # => :initialize

  def self.from_csv(path)
    DistrictRepository.new(path)  # => #<DistrictRepository:0x007fe02109b740 @path="/Users/sekharpaladugu/code/projects/headcount/data", @district_data=nil, @district_name=nil>
  end                             # => :from_csv

  def create_district(district_data, district_name)
    District.new(district_data, district_name)       # => #<District:0x007fe022dcc260 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data...
  end                                                # => :create_district

  def find_by_name(district)
    district_data = Parse.new(path).parse(district)  # => {"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.706"}, {:location=>"ACADEMY 20", :scor...
    district_name = district                         # => "ACADEMY 20"
    if district_data != nil                          # => true
      create_district(district_data, district_name)  # => #<District:0x007fe022dcc260 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data...
    else
      nil
    end                                              # => #<District:0x007fe022dcc260 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data...
  end                                                # => :find_by_name

  # def find_all_matching(name)
  #   # ???
  #   if district_data.empty?
  #     []
  #   else
  #     # ???
  #   end
  # end

end  # => :find_by_name

path = File.expand_path("../data", __dir__)                                                   # => "/Users/sekharpaladugu/code/projects/headcount/data"
repository = DistrictRepository.from_csv(path)                                                # => #<DistrictRepository:0x007fe02109b740 @path="/Users/sekharpaladugu/code/projects/headcount/data", @district_data=nil, @district_name=nil>
district = repository.find_by_name("ACADEMY 20")                                              # => #<District:0x007fe022dcc260 @district_data={"3rd grade students scoring proficient or above on the CSAP_TCAP"=>[{:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.857"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.824"}, {:location=>"ACADEMY 20", :score=>"Math", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.849"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.866"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.862"}, {:location=>"ACADEMY 20", :score=>"Reading", :timeframe=>"2010", :dataformat=>"Percent", :data=>"0.864"}, {:location=>"ACADEMY 20", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.671"}, {:location=>"ACADEMY 20", :score=>"Writing", :timefra...
st_test = district.statewide_testing.proficient_by_grade(3)                                   # => {2008=>{:math=>0.857, :reading=>0.866, :writing=>0.671}, 2009=>{:math=>0.824, :reading=>0.862, :writing=>0.706}, 2010=>{:math=>0.849, :reading=>0.864, :writing=>0.662}, 2011=>{:math=>0.819, :reading=>0.867, :writing=>0.678}, 2012=>{:reading=>0.87, :math=>0.83, :writing=>0.65517}, 2013=>{:math=>0.8554, :reading=>0.85923, :writing=>0.6687}, 2014=>{:math=>0.8345, :reading=>0.83101, :writing=>0.63942}}
st_test = district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)  # => 0.857
# st_test = district.statewide_testing.proficient_by_race_or_ethnicity(:asian)
# st_test = district.statewide_testing.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
