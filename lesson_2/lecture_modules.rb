# Classes can only sub class from one super class (single inheritance)
# This can make it difficult to model the problem domain
# Some languages allow a class to sub class directly from multiple super classes (multiple inheritance), but not Ruby
# Ruby's answer is mixing in behaviors via modules and mix-ins

# Example below. You wouldn't necessarily want `Fish` and `Dog` to sub class from the same parent, so you can use module instead

# module Swimmable
#   def swim
#     "swimming!"
#   end
# end

# class Dog
#   include Swimmable
#   # ... rest of class omitted
# end

# class Fish
#   include Swimmable
#   # ... rest of class omitted
# end

# It's as if we copied and pasted the methods in Swimmable in both Dog and Fish.