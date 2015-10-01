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
    @district_data[district_name.upcase] ||= create_district(
      Parse.new(path).parse(district_name),
      district_name
    )
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
