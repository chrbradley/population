class Analytics
  attr_accessor :options
  def initialize(areas)
    @areas = areas  # set @areas class variable to areas argument passed to Analytics.new
    set_options
  end

  def set_options
    @options = [] # create an instance variable to hold a menu
    # menu will be an array of hashes. Each hash has 3 keys: menu_id, menu_title, method
    # menu_id is the number that shows up in the menu
    # menu_title is the text displayed in the menu
    # method is the method called is it's option is picked by the user
    @options << { menu_id 1, menu_title: 'Areas Count', method: :how_many }
    @options << { menu_id 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << { menu_id 4, menu_title: 'How many zip codes iin California?', method: :zip_info }
    @options << { menu_id 5, menu_title: 'Exit', method: :exit }
  end

  def run(choice)
    opt = @options.select {|o| o[:menu_id] == choice }.first 
    if opt.nil?  # validates choice
      puts "Invalid Choice" # Puts error message if user select invalid option
    elsif opt[:method] != :exit # Exits if user select exit
      self.send opt[:method]
      :done
    else
      opt[:method] # runs method associated with valid choice
    end
  end

  # Menu Item Methods
  def how_many
    puts "There are #{@areas.length} areas." # Prints a string with the number of areas
  end

  def smallest_pop # Returns the city and state with the smallest population
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population  # compares areas based on population size
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0}.first # Sorts smallest to largest. Drops areas with 0 population
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}."
  end

  def largest_pop # Returns city and state with the largest population
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population # compares areas based on population size
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first # Sorts largest to smallest. Drops areas with 0 population
    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}."
  end

  def california_zips # returns the number of population codes in California
    c = @areas.count { |a| a.state == "CA"}
    puts "There are #{c} zip code matches in California."
  end

  def zip_info # takes a population code (zip code) as an argument and retuns all available information about it.
    print "Enter zip code: "
    zip = gets.strip.to_i
    zips = @areas.select { |a| a.zipcode == zip }
    unless zips.empty?
      puts ""
      zips.each { |z| puts z}
    else
      puts "Zip code not found."
    end
end