class Cat
  attr_accessor :name, :color

  def initialize(name, color="purple")
    @name = name
    @color = color
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{color} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

## Their solution uses a constant instead of an extra instance with a default param:

class Cat
  COLOR = 'purple'

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet