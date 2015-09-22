require 'csv'

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.from_csv(path)
    #load all 18 files - use a class called CSV and read in one at a time - parse them, stick them in a hash
    #finish with a giant hash of everything
  end

  def self.find_by_name

  end

  def opening_the_csv
    data = CSV.read(File(file.csv), headers: true, header_converters: :symbol).map { |row| row.to_h }
  end

end
