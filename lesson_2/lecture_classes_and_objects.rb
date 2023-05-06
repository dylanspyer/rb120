# Problem 1

# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# p bob.name = 'Robert'
# p bob.name                  # => 'Robert'

# Problem 2

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts[0]
#     @last_name = parts.size > 1 ? parts[1] : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

# end

# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# puts bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'

# Problem 3

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts[0]
    @last_name = parts.size > 1 ? parts[1] : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    if parts.size > 1
      self.first_name = parts[0]
      self.last_name = parts[1]
    else
      self.first_name = parts[0]
      self.last_name = ''
    end
  end

end

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

# Problem 4

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts[0]
#     @last_name = parts.size > 1 ? parts[1] : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     parse_full_name(full_name)
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     if parts.size > 1
#       self.first_name = parts[0]
#       self.last_name = parts[1]
#     else
#       self.first_name = parts[0]
#       self.last_name = ''
#     end
#   end

# end

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# p bob.name == rob.name

# # Problem 5

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}" # prints "The person's name is #{bob's object number}" because when we use interpolation, we're calling `to_s`. We haven't defined a custom `to_s`.

# Problem 6

# If you add your own `to_s`...

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts[0]
    @last_name = parts.size > 1 ? parts[1] : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    if parts.size > 1
      self.first_name = parts[0]
      self.last_name = parts[1]
    else
      self.first_name = parts[0]
      self.last_name = ''
    end
  end

end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" # now we called the custom `to_s` method

