# Polymorphism - different object types can respond to the same method invocation in different (or the same) ways

# Polymorphism through inheritance:

# class Animal
#   def move
#   end
# end

# class Fish < Animal
#   def move
#     puts "swim"
#   end
# end

# class Cat < Animal
#   def move
#     puts "walk"
#   end
# end

# Sponges and Corals don't have a separate move method - they don't move
# class Sponge < Animal; end
# class Coral < Animal; end

# animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
# animals.each { |animal| animal.move }
# Each object in the `animals` array has an associated `move` method

# Polymorphism through duck typing
# Duck typing is when different unrelated types both respond to the same method name.
# We're not concerned with the class or type of an object, we care about that object's behavior
# Quacks like a duck, must be a duck.
# Example would be a method called `handleClick`
  # You could apply `HandleClick` to everything that gets clicked
  # Checkbox, textfield, whatever as long as it gets clicked
# Here's polymorphic behavior without duck typing. This is an example of how NOT to do it:
# class Wedding
#   attr_reader :guests, :flowers, :songs

#   def prepare(preparers)
#     preparers.each do |preparer|
#       case preparer
#       when Chef
#         preparer.prepare_food(guests)
#       when Decorator
#         preparer.decorate_place(flowers)
#       when Musician
#         preparer.prepare_performance(songs)
#       end
#     end
#   end
# end

# class Chef
#   def prepare_food(guests)
#     # implementation
#   end
# end

# class Decorator
#   def decorate_place(flowers)
#     # implementation
#   end
# end

# class Musician
#   def prepare_performance(songs)
#     #implementation
#   end
# end

# The `prepare` method has too many dependencies and will have to be re-written if we change any of them. Here's a better way:

# class Wedding
#   attr_reader :guests, :flowers, :songs

#   def prepare(preparers)
#     preparers.each do |preparer|
#       preparer.prepare_wedding(self)
#     end
#   end
# end

# class Chef
#   def prepare_wedding(wedding)
#     prepare_food(wedding.guests)
#   end

#   def prepare_food(guests)
#     #implementation
#   end
# end

# class Decorator
#   def prepare_wedding(wedding)
#     decorate_place(wedding.flowers)
#   end

#   def decorate_place(flowers)
#     # implementation
#   end
# end

# class Musician
#   def prepare_wedding(wedding)
#     prepare_performance(wedding.songs)
#   end

#   def prepare_performance(songs)
#     #implementation
#   end
# end

# Each preparer provides a `prepare_wedding`

# Another note -
# Merely having 2 different objects that have a method with the same name and compatible arguments doesn't necessarily mean it's polymorphism
# Here's an example:

# class Circle
#   def draw; end
# end

# class Blinds
#   def draw; end
# end

# Maybe Circle#draw draws a circle while Blinds#draw closes the blinds
# They are both `draw` methods and both take no arguments, but they have nothing to do with each other
# Unless you call the method polyphormetically (for example, iterate through a Circle object and a Blinds object and call `draw` on each iteration)
# Then you don't have polymorphism.
# Polymorphism is intentional. If no intention (we happened to name 2 methods `draw`), no polymorphism.

# My example of something that looks like polymorphism, but isn't:

# class Baseball
#   def bat_noise
#     "Batter up!"
#   end
# end

# class Flying_animals
#   def bat_noise
#     "Squeak squeak squeak..."
#   end
# end

# Encapsulation

# It lets us hide the internal representation of an object from the outside
# And only expose the methods and properties that users of the object need.

# class Dog
#   attr_reader :nickname

#   def initialize(n)
#     @nickname = n
#   end

#   def change_nickname(n)
#     self.nickname = n
#   end

#   def greeting
#     "#{nickname.capitalize} says Woof Woof!"
#   end

#   private
#     attr_writer :nickname
# end

# dog = Dog.new("rex")
# dog.change_nickname("barny") # changed nickname to "barny"
# puts dog.greeting # Displays: Barny says Woof Woof!

