######## Exercises - Classes and Objects I

# class GoodDog
#   def initialize
#     puts "This object was initialized!"
#   end
# end

# sparky = GoodDog.new

# class GoodDog
#   def initialize(name)
#     @name = name
#   end

#   def get_name
#     @name
#   end

#   def set_name=(name) # We denote "setter" methods differently - `set_name=`
#     @name = name
#   end

#   def speak
#     "#{@name} says Arf!"
#   end
# end

# sparky = GoodDog.new("sparky")
# # p sparky.speak

# fido = GoodDog.new("fido")
# p fido.speak

# Interesting that @name can access the names 'sparky' and 'fido' even though we aren't explicitly passing them in as an argument

# p sparky.get_name

# If you had tried sparky.name before creating the `get_name` method, it wouldn't work.
# `get_name` is a "getter", whose sole purpose is to retrieve the value in the `@name` instance variable


# sparky.set_name=("Spartacus") # Note that even though we init a setter with set_name=(name), we don't need to call it like `spark.set_name=("Spartacus")`
# sparky.set_name = "Spartacus" # This is the same thing!
# p sparky.get_name


# # As a convention, you want the getters and setters to use the same name as the instance variable they are exposing and setting:
# class GoodDog
#   def initialize(name) # The constructor builds the object when a new object is instantiated
#     @name = name
#   end

#   def name             # This was `get_name`
#     @name
#   end

#   def name=(n)         # This was `set_name`
#     @name = n
#     "This doesn't do anything, the setter will still return the value passed in as an argument"
#   end

#   def speak
#     "#{@name} says arf!"
#   end
# end

# p fido.speak
# p sparky.speak

# Instead of a getter and a setter, we can use a shortcut: attr_accessor

# class GoodDog
#   attr_accessor :name  # This replaces your getter and setter

#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "#{name} says arf!" # It makes more sense to reference the getter than the instance variable itself...otherwise you'd need to do it for every instance
#   end

# end

# Alternatively, if you just want a getter but not a setter, you can use `attr_reader`.  Vice versa - `attr_writer`.

# Exercises

# class MyCar

#   attr_accessor :color, :model
#   attr_reader :year

#   def self.gas_mileage(gallons, miles)
#     puts "Your car gets #{miles / gallons} miles per gallon of gas"
#   end

#   def color
#     @color
#   end

#   def color=(color)
#     @color = color
#   end

#   def initialize(year, model, color)
#     @year = year
#     @model = model
#     @color = color
#     @current_speed = 0
#   end

#   def speed_up(number)
#     @current_speed += number
#     puts "You push the gas and accelerate #{number} mph."
#   end

#   def brake(number)
#     @current_speed -= number
#     puts "You push the brake and decelerate #{number} mph."
#   end

#   def current_speed
#     puts "You are now going #{@current_speed} mph."
#   end

#   def shut_down
#     @current_speed = 0
#     puts "Let's park this bad boy!"
#   end

#   def spray_paint (color)
#     @color = color
#     puts "Your new #{color} paint job looks great!"
#   end

#   def to_s
#     "This car is a #{color} #{year} #{model}."
#   end

# end

# my_car = MyCar.new("2012", "Buick", "White")
# MyCar.gas_mileage(13, 351)
# puts my_car # puts calls `to_s`... I needed to add a getter for `model`, or I could have referenced the instance variable `@model`

# lumina = MyCar.new(1997, 'chevy lumina', 'white')
# lumina.speed_up(20)
# lumina.current_speed
# lumina.speed_up(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.shut_down
# lumina.current_speed

# p lumina.color
# lumina.spray_paint('yellow')
# p lumina.color
# p lumina.color = 'yellow' # setter
# p lumina.color

# class GoodDog
#   DOG_YEARS = 7

  # attr_accessor :name, :age

  # def name=(name)
  #   @name = name
  # end

  # def age=(age)
  #   @age = age
  # end

  # def age
  #   @age
  # end

  # def initialize(n, a)
  #   self.name = n
  #   self.age = a * DOG_YEARS
  # end

#   def initialize(n, a)
#     self.name=(n)
#     self.age=(a * DOG_YEARS)  # Instead of access @age, you're calling the setter... this is the long way of writing that...
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# puts sparky.age # => 28

# class Person
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"

# class Animal
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# class GoodDog < Animal
#   def initialize(color)
#     super
#     @color = color
#   end
# end

# class BadDog < Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# p BadDog.new(2, 'bear')

# class Animal
#   def initialize
#   end
# end

# class Bear < Animal
#   def initialize(color)
#     super() # we tell Ruby that we don't want to forward any arguments... if we don't, we get a wrong num of args error b/c superclass doesn't take args
#     @color = color
#   end
# end

# bear = Bear.new('black')

# class GoodDog
#   DOG_YEARS = 7

#   attr_accessor :name, :age

#   def initialize(n, a)
#     self.name = n
#     self.age = a
#   end

#   def public_disclosure
#     "#{self.name} in human years is #{human_years}"
#   end

#   private

#   def human_years
#     age * DOG_YEARS
#   end

# end

# sparky = GoodDog.new("Sparky", 4)
# p sparky.public_disclosure

# class Person
#   def initialize(age)
#     @age = age
#   end

#   def older?(other_person)
#     age > other_person.age
#   end

#   protected

#   attr_reader :age
  
# end

# malory = Person.new(64)
# sterling = Person.new(42)

# p malory.older?(sterling)
# p sterling.older?(malory)


###### Exercises

# class Vehicle
#   @@number_of_vehicles = 0

#   attr_accessor :color, :model, :year

#   def self.gas_mileage(gallons, miles)
#     puts "Your car gets #{miles / gallons} miles per gallon of gas"
#   end

#   def initialize(year, model, color)
#     @year = year
#     @model = model
#     @color = color
#     @current_speed = 0
#     @@number_of_vehicles += 1
#   end

#   def self.display_number_of_vehicles
#     @@number_of_vehicles
#   end

#   def speed_up(number)
#     @current_speed += number
#     puts "You push the gas and accelerate #{number} mph."
#   end

#   def brake(number)
#     @current_speed -= number
#     puts "You push the brake and decelerate #{number} mph."
#   end

#   def current_speed
#     puts "You are now going #{@current_speed} mph."
#   end

#   def shut_down
#     @current_speed = 0
#     puts "Let's park this bad boy!"
#   end

#   def spray_paint (color)
#     @color = color
#     puts "Your new #{color} paint job looks great!"
#   end

#   def age
#     puts "Your #{self.model} is #{calculate_vehicle_age} years old."
#   end

#   private
  
#   def calculate_vehicle_age
#     Time.now.year - self.year.to_i
#   end

# end

# class MyCar < Vehicle
#   NUMBER_OF_DOORS = 4
#   def to_s
#     "This car is a #{color} #{year} #{model}."
#   end
# end

# module Towable
#   def can_tow?(pounds)
#     pounds < 2000
#   end
# end

# class MyTruck < Vehicle
#   include Towable
#   NUMBER_OF_DOORS = 2
#   def to_s
#     "This truck is a #{color} #{year} #{model}."
#   end
# end



# my_car = MyCar.new('2012', 'Buick Century', 'White')
# my_truck = MyTruck.new('2010', 'Toyota Tacoma', 'Black')
# my_car = MyCar.new('2012', 'Buick Century', 'White')
# my_truck = MyTruck.new('2010', 'Toyota Tacoma', 'Black')

# my_car.age

# my_car.speed_up(30)
# my_truck.speed_up(40)

# puts my_car
# puts my_truck.can_tow?(2000)
# puts Vehicle.display_number_of_vehicles

# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors


# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(other_person)
#     grade.to_i > other_person.grade.to_i
#   end

#   protected

#   attr_reader :grade
# end

# dylan = Student.new("Dylan", 96)
# bob = Student.new("Bob", 88)

# puts "well done!" if dylan.better_grade_than?(bob)


# class Person

#   def public_hi
#     hi
#   end

#   private
  
#   def hi
#     puts 'hi'
#   end

# end

# bob = Person.new
# bob.public_hi


# NoMethodError: private method 'hi' called for `object`
# The problem is that `hi` is a private method
# We can simply make `hi` a public method by removing it from the private methods section