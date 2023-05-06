# Building Blocks:
  # Classes group common behaviors
  # Objects encapsulate state (you can't access instance variables outside of the class without using a getter, for example)
  # Object's state is saved in instance variables
  # Instance methods can operate on instance variables
# Instance variables don't only have to be strings or integers:
# class Person
#   def initialize
#     @heros = ['Superman', 'Spiderman', 'Batman']
#     @cash = {'ones' => 12, 'fives' => 2, 'tens' => 0, 'twenties' => 2, 'hundreds' => 0}
#   end

#   def cash_on_hand
#     # uses @cash to calculate total cash value
#   end

#   def heroes
#     @heroes.join(', ')
#   end

# end

# joe = Person.new
# joe.cash_on_hand #=> $62 dollars (random made up number...)
# joe.heros #=> "Superman, Spiderman, Batman"

# Instance variables can be set to any object, even ones of other custom classes:
# class Person
#   attr_accessor :name, :pet

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Robert")
# bud = Bulldog.new # don't worry about what the Bulldog class looks like, it doesn't matter for this example

# bob.pet = bud # We set the instance variable `@pet` of the object `bob` to an object of another class `bud`
#               # We can even chain methods from bulldog onto `bob.pet` since `bob.pet` returns a `Bulldog` object

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Cat
end

class Bulldog
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud

p bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]

# Now we have an array of different objects within `bob`. `pets` has an object from `Cat` and `Bulldog`.
# We can't call methods from `Cat` or `Bulldog` directly on the array, we need to parse the objects and call their respective methods:
bob.pets.each do |pet|
  pet.jump
end

# My note: the above is a perfect example of polymorphism

