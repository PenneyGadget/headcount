require 'csv'
require 'pry'
require_relative 'parse'

class DistrictRepository
  attr_accessor :data, :contents

  def initialize
    @data = data
    @contents = []
  end

  def districts
    contents = CSV.read(('./data/Pupil enrollment.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
    contents.map! do |hash|
      hash.fetch(:location)
    end
    puts districts = contents.uniq
  end

  def find_by_name(name)
    index = districts.index(name)
    if index.nil?
      puts "nil"
    else
      puts districts[index]
    end
  end

  def find_all_matching(fragment)
    skip
    all_matching = []
    districts.each do |district|
      if district.include?(fragment)
        all_matching << district
      end
    end
    all_matching
  end

  def self.from_csv(path)
    data = Parse.new
    #load all 18 files - use a class called CSV and read in one at a time - parse them, stick them in a hash
    #finish with a giant hash of everything
  end

  def self.find_by_name(name)

  end

  def opening_the_csv
    data = CSV.read(File(file.csv), headers: true, header_converters: :symbol).map { |row| row.to_h }
  end

end

dr = DistrictRepository.new
dr.districts
# dr.find_all_matching("CHERRY")
