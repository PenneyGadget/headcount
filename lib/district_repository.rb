require 'csv'
require 'pry'

class DistrictRepository
  attr_accessor :data

  def initialize
    @data = []
  end

  def districts
    data = CSV.read(('./data/Pupil enrollment.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
    data.map! do |hash|
      hash.fetch(:location)
    end
    puts districts = data.uniq
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

  def self.from_csv
    #load all 18 files - use a class called CSV and read in one at a time - parse them, stick them in a hash
    #finish with a giant hash of everything
  end

end

dr = DistrictRepository.new
dr.districts
# dr.find_all_matching("CHERRY")
