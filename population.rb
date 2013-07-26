require_relative 'lib/setup'  # => Access to setup.rb
require_relative ' lib/analytics' # => Access to analytics.rb

class Population
  attr_accessor :analytics

  def initialize
    areas = Setup.new().areas # => Call Setup method, assign areas to new variable
    @analytics = Analytics.new(areas) # => assigns instance variable a new instance of Analytics, passes areas variable
  end

  def menu
    system 'clear'   # => clears
    puts "Population Menu"
    puts "---------------"

    @analytics.options.each do |opt|  # => iterates over @analytics.options
      puts "#{opt[menu_id]}. #{opt[:menu_title]}" # => Prints each option's menu_id and menu_title
    end
  end

  def run
    stop = false
    while stop != :exit do
      self.menu_title # => run the menu method
      
      print "Choice: "  # => grab the choice from the user
      choice = gets.strip.to_i

      stop = @analytics.run(choice) # => call run on analytics with the choice
      if stop == :Exiting # => based on what that returns either exit or
        puts "Exiting"
      else
        print "\nHit enter to continue..."  # => ask user to hit enter (this pauses the loop)
        gets
      end
    end
  end

end

p = Population.new # => creates new instance of Population class
p.run # => executes run method which starts the program
