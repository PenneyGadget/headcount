require 'csv'

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def opening_the_csv
    data = CSV.read(File(file.csv), headers: true, header_converters: :symbol).map { |row| row.to_h }
  end

end
