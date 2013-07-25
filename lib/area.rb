class Area
  attr_accessor :zipcode, :estimated_population, :city, :state 
  def initialize(hash={})
    @zipcode = hash[:zipcode].to_i || 0
    @estimated_population = hash[:estimated_population].to_i || 0
    @city = hash[:city] || "n/a"
    @state = hash[:state] || "n/a"
  end

  def to_s
    "#{@city}, #{@state} #{@zipcode} has a population of #{@estimated_population} people"
  end
end