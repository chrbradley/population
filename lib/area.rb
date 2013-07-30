class Area
  attr_accessor :zipcode, :estimated_population, :city, :state, :total_wages 
  def initialize(hash={})
    @zipcode = hash[:zipcode] || "00000"
    @estimated_population = hash[:estimated_population].to_i || 0
    @city = hash[:city] || "n/a"
    @state = hash[:state] || "n/a"
    @total_wages = hash[:total_wages].to_i || 0
  end

  def to_s
    "#{@city}, #{@state} #{@zipcode} has a population of #{@estimated_population} people. They're average total wages are #{@total_wages}"
  end
end