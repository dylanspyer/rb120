class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
p Cat.ancestors

# Cat -> Animal -> Object -> Kernel -> BasicObject