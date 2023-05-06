# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     name = @name.clone.upcase
#     "My name is #{name}."
#   end
# end

class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
    puts @name.object_id # two different objects
    puts name.object_id  # 
  end

  def to_s
    "My name is #{@name}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # "Fluffy"
# puts fluffy      # "My name is FLUFFY."
# puts fluffy.name # "FLUFFY"
# puts name        # "FLUFFY"

name = 42
fluffy = Pet.new(name)
name += 1 # we incremented name outside of the scope of the class `Pet`. `name` and `@name` used to reference the same thing, but now they don't
puts fluffy.name
puts fluffy
puts fluffy.name
puts name # now when we `puts name` it's 43