require 'csv'
require 'pry'
require_relative 'parse'
require_relative 'district'

class DistrictRepository
  attr_accessor :district_data, :path, :district_name

  def initialize(path)
    @path = path
    @district_data = district_data
    @district_name = district_name
  end

  def self.from_csv(path)
    DistrictRepository.new(path)
  end

  # def self.from_json(path)
  #   skip
  # end

  def create_district(district_data, district_name)
    District.new(district_data, district_name)
  end

  def find_by_name(district)
    district_data = Parse.new(path).parse(district)
    district_name = district
    if district_data != nil
      create_district(district_data, district_name)
    else
      nil
    end
  end

  # def find_all_matching(name)
  #   # ???
  #   if district_data.empty?
  #     []
  #   else
  #     # ???
  #   end
  # end

end

path = File.expand_path("../data", __dir__)
repository = DistrictRepository.from_csv(path)
district = repository.find_by_name("ACADEMY 20")
binding.pry

ec_test = district.economic_profile.free_or_reduced_lunch_in_year(2012)
