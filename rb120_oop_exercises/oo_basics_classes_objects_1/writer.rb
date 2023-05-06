class Cat
  attr_reader :name
  # attr_writer :name

  def name=(name)
    @name = name
  end

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.name = "Luna"
kitty.greet