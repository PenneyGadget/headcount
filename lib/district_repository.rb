require 'pry'                # => true
require_relative 'parse'     # => true
require_relative 'district'  # => true

class DistrictRepository
  attr_accessor :district_data, :path, :district_name  # => nil

  def initialize(path)
    @path          = path           # => "/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data"
    @district_name = district_name  # => nil
    @district_data = {}             # => {}
  end

  def self.from_csv(path)
    DistrictRepository.new(path)  # => #<DistrictRepository:0x007ff1ea212cb0 @path="/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data", @district_name=nil, @district_data={}>
  end

  def create_district(district_data, district_name)
    District.new(district_data, district_name)
  end

  def find_by_name(district_name)
    path = File.expand_path("../data", __dir__)
    names_array = Parse.new(path).district_names_array
    if names_array.include?(district_name.upcase)
      @district_data[district_name.upcase] ||= create_district(
        Parse.new(path).parse(district_name),
        district_name
      )
    else
      nil
    end
  end

  def find_all_matching(name)
    path = File.expand_path("../data", __dir__)                       # => "/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data"
    names_array = Parse.new(path).district_names_array                # => ["COLORADO", "ACADEMY 20", "ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J", "AGATE 300", "AGUILAR REORGANIZED 6", "AKRON R-1", "ALAMOSA RE-11J", "ARCHULETA COUNTY 50 JT", "ARICKAREE R-2", "ARRIBA-FLAGLER C-20", "ASPEN 1", "AULT-HIGHLAND RE-9", "BAYFIELD 10 JT-R", "BENNETT 29J", "BETHUNE R-5", "BIG SANDY 100J", "BOULDER VALLEY RE 2", "BRANSON REORGANIZED 82", "BRIGGSDALE RE-10", "BRIGHTON 27J", "BRUSH RE-2(J)", "BUENA VISTA R-31", "BUFFALO RE-4", "BURLINGTON RE-6J", "BYERS 32J", "CALHAN RJ-1", "CAMPO RE-6", "CANON CITY RE-1", "CENTENNIAL R-1", "CENTER 26 JT", "CHERAW 31", "CHERRY CREEK 5", "CHEYENNE COUNTY RE-5", "CHEYENNE MOUNTAIN 12", "CLEAR CREEK RE-1", "COLORADO SPRINGS 11", "COTOPAXI RE-3", "CREEDE CONSOLIDATED 1", "CRIPPLE CREEK-VICTOR RE-1", "CROWLEY COUNTY RE-1-J", "CUSTER COUNTY SCHOOL DISTRICT C-1", "DE BEQUE 49JT", "DEER TRAIL 26J", "DEL NORTE C-7", "DELTA COUNTY 50(J)", "DENVER COUNTY 1", "DOLORES COUNTY R...
    names_array.keep_if { |district| district.include? name.upcase }  # => ["COLORADO", "COLORADO SPRINGS 11"]
  end

end

path = File.expand_path("../data", __dir__)     # => "/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data"
repository = DistrictRepository.from_csv(path)  # => #<DistrictRepository:0x007ff1ea212cb0 @path="/Users/Penney/Documents/Web Dev/Turing/projects/module_1/headcount/data", @district_name=nil, @district_data={}>
repository.find_all_matching("oRa")             # => ["COLORADO", "COLORADO SPRINGS 11"]
