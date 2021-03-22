class Car
  def initialize
    @parts = []
  end

  def add(part)
    @parts << part
  end

  def list_parts
    print "Car parts: #{@parts.join(', ')}"
  end
end

class ManualCar
  def initialize
    @parts = []
  end

  def add(part)
    @parts << part
  end

  def list_parts
    print "Car parts: #{@parts.join(', ')}"
  end
end

class Builder
  def reset
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def set_seats
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def set_engine
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def set_trip_computer
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def set_gps
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class CarBuilder < Builder
  def initialize
    reset
  end

  def set_seats(number_of_seats)
    @car.add("#{number_of_seats} seats")
  end

  def set_engine(engine_type)
  #  it can be an object also
  @car.add("#{engine_type} engine")
  end

  def set_trip_computer(computer_type)
    @car.add("#{computer_type} computer")
  end

  def set_gps(gps_name)
    @car.add("#{gps_name} gps")
  end

  def reset
    @car = Car.new
  end

  def get_product
    product = @car
    reset
    product
  end
end

class ManualCarBuilder < Builder
  def initialize
    reset
  end

  def set_seats(number_of_seats)
    @manual_car.add("#{number_of_seats} seats")
  end

  def set_engine(engine_type)
    #  it can be an object also
    @manual_car.add("#{engine_type} engine")
  end

  def set_trip_computer(computer_type)
    @manual_car.add("#{computer_type} computer")
  end

  def set_gps(gps_name)
    @manual_car.add("#{gps_name} gps")
  end

  def reset
    @manual_car = ManualCar.new
  end

  def get_product
    product = @manual_car
    reset
    product
  end
end

class Director
  attr_accessor :builder

  def initialize
    @builder = nil
  end

  def builder=(builder)
    @builder = builder
  end

  def construct_sport_car
    @builder.reset
    @builder.set_seats(2)
    @builder.set_engine('SportEngine')
    @builder.set_trip_computer('Trip Computer')
    @builder.set_gps('Google Gps')
  end

  def construct_suv
    @builder.reset
    @builder.set_seats(5)
    @builder.set_engine('SUVEngine')
    @builder.set_trip_computer('Trip Family Computer')
    @builder.set_gps('Google Gps')
  end
end

if $PROGRAM_NAME == __FILE__
  director = Director.new

  builder = CarBuilder.new
  director.builder = builder

  puts 'Constructing a Car'
  director.construct_sport_car
  puts builder.get_product.list_parts

  builder = ManualCarBuilder.new
  director.builder = builder

  puts 'Constructing a Manual Car'
  director.construct_suv
  puts builder.get_product.list_parts
end