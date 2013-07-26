require_relative 'csv_reader' # => looks for cvs_reader.rb
require_relative 'area'  # => looks for area.rb

class Setup
  attr_accessor :areas
  def initialize
    csv = CSVReader.new("./free-zipcode-database.csv") # => creates new instance of the CVSReader class with ./free-zipcode-database.csv
    
    @areas = [] # => initialize @area array
    csv.read do |item|  # => calls read method on csv instance
      @areas << Area.new(item)  # => for each item in cvs instance, create a new Area instance and adds it to @areas
    end

    self # => returns itself

  end
end
