require_relative 'lib/setup'  # => Access to setup.rb
require_relative 'lib/analytics' # => Access to analytics.rb

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

    # index = 1
    @analytics.options.each_with_index do |opt,index|  # => iterates over @analytics.options
      # puts "#{opt[:menu_id]}. #{opt[:menu_title]}" # => Prints each option's menu_id and menu_title
      puts "#{index+1}. #{opt[:menu_title]}" # => Prints each option's menu_id and menu_title
      opt[:m_id] = index+1
      # index +=1
    end
  end

  def run
    stop = false
    while stop != :exit do
      self.menu  # => run the menu method
      
      print "Type a number: "  # => grab the choice from the user
      choice = gets.strip.to_i

      stop = @analytics.run(choice) # => call run on analytics with the choice
      if stop == :exit # => based on what that returns either exit or
        puts "Exiting"
      else
        print "\nHit enter to play again..."  # => ask user to hit enter (this pauses the loop)
        gets
      end
    end
  end

end

p = Population.new # => creates new instance of Population class
p.run # => executes run method which starts the program