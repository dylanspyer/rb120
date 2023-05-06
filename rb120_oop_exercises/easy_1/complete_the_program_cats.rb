class Pet
  attr_reader :name, :age, :color

  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end
end

class Cat < Pet

  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end

end

class PolarBear < Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

yogi = PolarBear.new('Yogi', 65)
p yogi.color