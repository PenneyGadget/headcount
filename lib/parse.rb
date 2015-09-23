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
    ac_frl = ac.find_all { |hash| hash[:poverty_level] == "Eligible for Free or Reduced Lunch" }
    ac_percent = ac_frl.find_all { |hash| hash[:dataformat] == "Percent" }
    binding.pry
  end

end

info = Parse.new("Students qualifying for free or reduced price lunch.csv")
info.parse
