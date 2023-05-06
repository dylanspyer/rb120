# # Problem 1

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"

# bigs = Bulldog.new
# puts bigs.speak
# puts bigs.swim

# # Problem 2
# class Pet
#   def run
#     'running!'
#   end

#   def jump
#     'jumping!'
#   end
# end

# class Dog < Pet
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end

#   def fetch
#     'fetching!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# class Cat < Pet
#   def speak
#     'meow!'
#   end
# end

# pete = Pet.new
# kitty = Cat.new
# dave = Dog.new
# bud = Bulldog.new

# p pete.run                # => "running!"
# # pete.speak              # => NoMethodError

# p kitty.run               # => "running!"
# p kitty.speak             # => "meow!"
# # kitty.fetch             # => NoMethodError

# p dave.speak              # => "bark!"

# p bud.run                 # => "running!"
# p bud.swim                # => "can't swim!"

# Problem 3

# Pet -> [Dog -> [Bulldog], Cat]

# Problem 4

# Method lookup path is the classes that Ruby looks through to find the method being called.
# Ruby starts at the closest class. If it finds the method it's searching for, it will stop and use that one.
# If it doesn't find it, it'll look in the parent, then grandparent, etc.