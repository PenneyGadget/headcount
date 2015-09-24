require 'csv'
require 'pry'
require_relative 'parse'

class DistrictRepository < Parse
  attr_reader :data

  def initialize
    @data = []
  end

  def self.from_csv(path)
    district_data = Parse.new(path)
    district_data.parse("ACADEMY 20")
  end

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

path = File.expand_path("../data", __dir__)
repository = DistrictRepository.from_csv(path)
binding.pry
# dr.from_csv("ACADEMY 20")
