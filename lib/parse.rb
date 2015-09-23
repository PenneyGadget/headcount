require 'csv'
require 'pry'

class Parse
  attr_reader :data, :file, :district, :district_data, :path

  def initialize(path)
    @data = data
    @file = file
    @path = path
    @district = district
    @district_data = []
  end

  def file_names
    file_names = []
    Dir.foreach(path) { |file| file_names << file }
    file_names.shift
    file_names.shift
    file_names
  end

  def parse(district)
    file_names.each do |file|
      file_path = File.join(path, file)
      contents = CSV.read(file_path, headers: true, header_converters: :symbol).map { |row| row.to_h }
      @district_data << contents.find_all { |hash| hash[:location] == district}
    end
    return district_data
    # district data here is an array, of arrays of hashes which correspond to each row of CSVs
    # for just one district
  end

end

path = File.expand_path("../data", __dir__)
data = Parse.new(path)
data.parse("ACADEMY 20")
binding.pry
