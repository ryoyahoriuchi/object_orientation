class Juice
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def to_s
    "name: #{@name}, price: #{@price}"
  end

  def to_h
    {name: @name, price: @price}
  end

  def self.coke
    Juice.new("コーラ", 120)
  end

  def self.water
    self.new("水", 100)
  end
end

puts coke = Juice.coke
puts water = Juice.water
puts coke.to_h