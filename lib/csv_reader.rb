class CSVReader
  attr_accessor :fname, :headers

  def initialize(filename)
    @fname = filename
  end

  def headers=(header_str)
    @headers = header_str.split(',') # => split on comma

    @headers.map! do |h|
      
      new_header = h.gsub('"', '') # => remove quotes
      
      new_header.strip! # => remove new line characters

      new_header.underscore.to_sym # => converts to snake_case (.underscore), converts to symbol (.to_sym)
    end
  end

  def create_hash(values)
    h = {}
    @headers.each_with_index do |header, i|
      value = values[i].strip.gsub('"','') # => removes quotes and new-line chars
      h[header] = value unless value.empty? # => populates hash with the cleansed value
    end
    h
  end

  def read
    f = File.new(@fname, 'r')  # => creats a new, read-only, instance of File class from filename variable passed in initialize
  
    self.headers = f.readline # => .readline reads one line at a time. The first line is the headers for the csv file.

    while (!f.eof && next_line = f.readline)  # => until the end of File instance
      values = next_line.split(',')  # => set each line to variable values
      hash = create_hash(values)  # => add values to hash
      yield(hash)  # => return hash to block it was called from
    end
  end

end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

end