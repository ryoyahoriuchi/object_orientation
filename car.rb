class Car

  def initialize
    @fuel_gauge = 100
    @speed_meter = 0
  end

  def get_status
    puts("fuel_gauge:" + @fuel_gauge.to_s)
    puts("speed_meter:" + @speed_meter.to_s)
  end

  def run
    @fuel_gauge -= 1
    @speed_meter += 1
  end

  def stop
    @speed_meter = 0
  end

  def refuel
    if @speed_meter == 0
      @fuel_gauge = 100
    else
      puts "Boo!!"
    end
  end
end

class BadCar
  attr_accessor :fuel_gauge, :speed_meter

  def initialize
    @fuel_gauge = 100
    @speed_meter = 0
  end

  def get_status
    puts("fuel_gauge:" + @fuel_gauge.to_s)
    puts("speed_meter:" + @speed_meter.to_s)
  end

  def run
    @fuel_gauge -= 1
    @speed_meter += 1
  end

  def stop
    @speed_meter = 0
  end

  def refuel
    if @speed_meter == 0
      @fuel_gauge = 100
    else
      puts "Boo!!"
    end
  end
end

class Truck < Car

  def initialize
    super
    @carrier = 0
  end

  def get_status
    super
    puts("carrier:" + @carrier.to_s)
  end

  def unload
    @carrier -= 1
  end

  def load
    @carrier += 1
  end

end

class SuperCar < Car

  def run
    super
    super
  end

end

if __FILE__ == $0
  puts "car"
  car = Car.new
  2.times do
    car.run
    puts car.get_status
  end
  car.stop
  puts car.get_status
  car.refuel
  puts "----"
  puts "badcar"
  badcar = BadCar.new
  2.times do
    badcar.run
    puts badcar.get_status
  end
  badcar.stop
  puts badcar.get_status
  badcar.refuel
  badcar.fuel_gauge += 10
  puts badcar.fuel_gauge
  puts "-----"
  truck = Truck.new
  truck.load
  truck.get_status
end