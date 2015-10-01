require 'pry'
require_relative 'parse'
require_relative 'district'

class DistrictRepository
  attr_accessor :district_data, :path, :district_name

  def initialize(path)
    @path          = path
    @district_name = district_name
    @district_data = {}
  end

  def self.from_csv(path)
    DistrictRepository.new(path)
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
    path = File.expand_path("../data", __dir__)
    names_array = Parse.new(path).district_names_array
    names_array.keep_if { |district| district.include? name.upcase }
  end

end

path = File.expand_path("../data", __dir__)
repository = DistrictRepository.from_csv(path)
repository.find_all_matching("oRa")
