require 'csv'
require 'pry'

class Parse
  attr_accessor :data, :file

  DATA_DIR = "./data/"

  def initialize(file)
    @data = data
    @file = file
  end

  def parse
    contents = CSV.read((File.join(DATA_DIR, @file)), headers: true, header_converters: :symbol).map { |row| row.to_h }

    grouped = contents.group_by do |hash|
      hash.fetch(:location)
    end

    ac = grouped.fetch("ACADEMY 20")
    ac_2012 = ac.find { |hash| hash[:timeframe] == "2012" }[:data]
    binding.pry
  end

end

info = Parse.new("Pupil enrollment.csv")
info.parse
