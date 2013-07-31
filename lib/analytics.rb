class Analytics
  attr_accessor :options, :m_id 
  def initialize(areas)
    @areas = areas  # => set @areas class variable to areas argument passed to Analytics.new
    set_options
  end

  def set_options
    @options = [] # => create an instance variable to hold a menu
    # => menu will be an array of hashes. Each hash has 3 keys: menu_id, menu_title, method
    # => menu_id is the number that shows up in the menu
    # => menu_title is the text displayed in the menu
    # => method is the method called is it's option is picked by the user
    @options << { menu_id: 6, menu_title: 'Ballers', method: :ballers}
    @options << { menu_id: 7, menu_title: 'Puapers', method: :paupers}
    @options << { menu_id: 8, menu_title: 'Palindromes', method: :palindrome}
    @options << { menu_id: 9, menu_title: 'Mattingly', method: :mattingly}
    @options << { menu_id: 1, menu_title: 'Areas Count', method: :how_many }
    @options << { menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id: 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << { menu_id: 4, menu_title: 'How many zip codes in California?', method: :california_zips }
    @options << { menu_id: 5, menu_title: 'Information for a given zip code:', method: :zip_info }
    @options << { menu_id: 10, menu_title: 'Exit', method: :exit }

  end

  def run(choice)
    opt = @options.select {|o| o[:m_id] == choice }.first 
    if opt.nil?  # => validates choice
      puts "Invalid Choice" # => Puts error message if user select invalid option
    elsif opt[:method] != :exit # => Exits if user select exit
      self.send opt[:method]
      :done
    else
      opt[:method] # => runs method associated with valid choice
    end
  end

  # => Menu Item Methods
  def how_many
    puts "There are #{@areas.length} areas." # => Prints a string with the number of areas
  end

  def smallest_pop # => Returns the city and state with the smallest population
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population  # => compares areas based on population size
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0}.first # => Sorts smallest to largest. Drops areas with 0 population
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}."
  end

  def largest_pop # => Returns city and state with the largest population
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population # => compares areas based on population size
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first # => Sorts largest to smallest. Drops areas with 0 population
    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}."
  end

  def california_zips # => returns the number of population codes in California
    c = @areas.count { |a| a.state == "CA"}
    puts "There are #{c} zip code matches in California."
  end

  def zip_info # => takes a population code (zip code) as an argument and retuns all available information about it.
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

  def ballers # => Returns city with highest total wages
    sorted = @areas.sort do |x,y|
      x.total_wages <=> y.total_wages # => compares areas based on wages
    end
    # largest = sorted.reverse.drop_while { |i| i.total_wages == 0}.first  # => sorts largest to smallest. Drops areas with ) total wages
    # puts "All the ballers, averaging #{largest.total_wages} dollars per year, ball in #{largest.city}, #{largest.state}."
    largest_10 = sorted.reverse.drop_while { |i| i.total_wages == 0}.uniq { |s| s.zipcode }.take(10)  # => sorts largest to smallest. Drops areas with ) total wages
    puts "The 10 best places to live if your're a Baller are:"
    # largest_10.each {|x| puts "Averaging #{x.total_wages} dollars per year, #{x.city}, #{x.state}."}
    largest_10.each {|x| puts "#{x.city}, #{x.state} in zip code #{x.zipcode}. The average income is #{x.total_wages} dollars per year," }
  end

  def paupers # => Returns city with lowest total wages
    sorted = @areas.sort do |x,y|
      x.total_wages <=> y.total_wages # => compares areas based on wages
    end
    lowest = sorted.drop_while { |i| i.total_wages ==0 }.uniq { |s| s.zipcode }.take(10) #  Sorts smallest to largest, droppng areas with 0 total wages
    puts "The 10 places you're least likely to run into a Baller are:"
    lowest.each { |x| puts "#{x.city}, #{x.state} in zip code #{x.zipcode}. The average income is #{x.total_wages} dollars per year," }
  end

  def palindrome # => Returns all palindrome zip codes
    sorted = @areas.sort do |x,y|
      x.zipcode <=> y.zipcode # => sorts based on zipcodes
    end
    
    strings =[] # => initialie
    palindromes = [] # => initialize

    sorted.each { |x| strings << x.zipcode.to_s} # => returns array of zipcode strings

    strings.each do |item| # => compares each zip with it's reverse
      if item == item.reverse
        palindromes << item # => if they match, add to palindrome array
      end
    end

    palindromes.uniq! # => eliminate duplicates
    puts "There are #{palindromes.size} palindrome zip codes. Here they are:"
    palindromes.each { |item| puts "#{item}"}
  end

  def mattingly # => returns all zip codes whose digits add upto 23
    sorted = @areas.sort do |x,y|
      x.zipcode <=> y.zipcode # => sorts based on zipcodes
    end

    strings = []
    sorted.reverse.each { |x| strings << x.zipcode.to_s} # => returns array of zipcode strings
    # sorted.reverse.take(10000).each { |x| strings << x.zipcode.to_s}
    # puts "strings size is #{strings.size}"
    strings.uniq! # => eliminates duplicates
    # puts "strings unique size is #{strings.size}"
    # integers.each { |x| puts "#{x}"}

    array_of_digits = [] # => initialize array to hold string/digit hashes
    digits_hash = {} # => initialize string/digit hash
    strings.each { |x| array_of_digits << {x => x.chars.map(&:to_i)}} # => takes each item from strings arrya, gets digit version, adds to string digit array
    # strings.each { |x| array_of_digits << x.chars.map(&:to_i)}
    # puts "array_of_digits size is #{array_of_digits.size}"
    # array_of_digits.each { |x| puts "#{x}" }

    donny_baseball = [] # => initialize array to hold valid results
    array_of_digits.each do |item| # => iterate over each string/digit pair
      item.each do |key, value| # => iterate over each digit
        index = 0
        total = 0
        while value[index]
          total += value[index] # => adds digits
          index += 1 # => increments
        end
      # puts "the total is #{total}"
          if total == 23 # => condition
            donny_baseball << key # => if satisfied add to array
          end
      end
    end
    puts "There are #{donny_baseball.size} Mattingly zip codes:"
    puts donny_baseball
    # donny_baseball.each { |x| puts "#{x}" }

  end

end