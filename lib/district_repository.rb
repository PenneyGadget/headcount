require 'csv'
require 'pry'
require_relative 'parse'
require_relative 'district'

class DistrictRepository
  attr_accessor :district_data, :path

  def initialize(path)
    @path = path
    @district_data = district_data
  end

  def self.from_csv(path)
    DistrictRepository.new(path)
  end

  # def self.from_json(path)
  #   skip
  # end

  def create_district(district_data)
    District.new(district_data)
  end

  def find_by_name(district)
    district_data = Parse.new(path).parse(district)
    if district_data.present?
      create_district(district_data)
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

  # def districts
  #   data = CSV.read(('./data/Pupil enrollment.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
  #   data.map! do |hash|
  #     hash.fetch(:location)
  #   end
  #   puts districts = data.uniq
  # end                                                                                                                   # => :districts

  # def find_by_name(name)
  #   skip
  #   index = districts.index(name)
  #   if index.nil?
  #     puts "nil"
  #   else
  #     puts districts[index]
  #   end
  # end

  # def find_all_matching(fragment)
  #   skip
  #   all_matching = []
  #   districts.each do |district|
  #     if district.include?(fragment)
  #       all_matching << district
  #     end
  #   end
  #   all_matching
  # end

end

# path = File.expand_path("../data", __dir__)
# repository = DistrictRepository.from_csv(path)
# district = repository.find_by_name("ACADEMY 20")
# frl_test = district.economic_profile.free_or_reduced_lunch_in_year(2012)
