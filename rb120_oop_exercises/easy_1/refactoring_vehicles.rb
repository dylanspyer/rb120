class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    self.class::WHEELS
  end
end

class Car < Vehicle
  WHEELS = 4
  # def wheels
  #   4
  # end
end

class Motorcycle < Vehicle  
  WHEELS = 2

  # def wheels
  #   2
  # end
end

class Truck < Vehicle
  WHEELS = 6

  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  # def wheels
  #   6
  # end
end

car = Car.new('Buick', 'Century')
puts car.wheels