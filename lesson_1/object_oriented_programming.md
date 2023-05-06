- [The Object Model](#the-object-model)
  - [Why Object Oriented Programming](#why-object-oriented-programming)
  - [What are Objects?](#what-are-objects)
  - [Classes Define Objects](#classes-define-objects)
  - [Modules](#modules)
  - [Method Lookup](#method-lookup)
  - [Exercises](#exercises)
- [Classes and Objects - Part I](#classes-and-objects---part-i)
  - [States and Behaviors](#states-and-behaviors)
  - [Initializing a New Object](#initializing-a-new-object)
  - [Instance Variables](#instance-variables)
  - [Instance Methods](#instance-methods)
  - [Accessor Methods](#accessor-methods)
    - [Accessor Methods in Action](#accessor-methods-in-action)
    - [Calling Methods With self](#calling-methods-with-self)
- [Classes and Objects II](#classes-and-objects-ii)
  - [Class Methods](#class-methods)
  - [Class Variables](#class-variables)
  - [Constants](#constants)
  - [The to\_s Method](#the-to_s-method)
  - [More About self](#more-about-self)
  - [Exercises](#exercises-1)
- [Inheritance](#inheritance)
  - [Class Inheritance](#class-inheritance)
  - [super](#super)
  - [Mixing in Modules](#mixing-in-modules)
  - [Inheritance vs Modules](#inheritance-vs-modules)
  - [Method Lookup Path](#method-lookup-path)
  - [More Modules](#more-modules)
  - [Private, Protected, and Public](#private-protected-and-public)
  - [Accidental Method Overriding](#accidental-method-overriding)
- [Attributes (FIRST NON-BOOK SECTION OF NOTES)](#attributes-first-non-book-section-of-notes)

# The Object Model

## Why Object Oriented Programming

**OOP** helps deal with software complexity of large software systems.

Generally, it is a way to create containers for data that can be changed without causing a ripple effect of errors due to dependencies.
A way to "section off" small parts of code.

**Encapsulation** is hiding pieces of functionality and making it unavailable to the rest of the code base. It defines the boundaries in your application.

Ruby accomplishes encapsulation by creating objects, and exposing interfaces (methods) to interact with those objects.

Objects are represented as real world nouns and can be given methods that describe the behavior the programmer is trying to represent.

**Polymorphism** is the ability for different data to respond to a common interface. For example, if we have a method that invokes `move` method on its argument,
we can pass the method any type of argument as long as the argument has a compatible `move` method. The object can represent anything.

Lets objects of different types respond to the same method invocation.

"Poly" -> "many"
"Morph" -> "forms"

OOP gives us the flexibility to use pre-written code for new purposes.

**Inheritance** is used in Ruby where a class inherits the behaviors of another class, referred to as a **superclass**.

Programmers can define basic classes with large reusability and smaller **subclasses** for more fine-grained behaviors.

**Module** is another way to apply polymorphism. Similar to classes in that they contain shared behavior.
However, you cannot create an object with a module. Module must be mixed in with a class using the `include` method invocation.
This is called a **mixin**.

## What are Objects?

"Everything is an object" isn't strictly true. Anything that can be said to have a value **is** an object.
Few things are not objects - methods, blocks, variables.

Objects are created from classes. Classes are like molds and objects are like things you make out of the molds.

Individual objects contain different info from other objects, but they are instances of the same class.

```ruby
"hello".class
#=> String
"world".class
#=> String
```

We use the `class` instance method to determine the class for each object. Everything we've been using so far are objects instantiated from a class.

## Classes Define Objects

Ruby defines the attributes and behaviors of objects in **classes**. A class is an outline of what an object should be made of and what it should do.

To define a class, we use similar syntax as defining a method, but instead we replace `def` with `class` and use CamelCase. We use `end` to finish (same as methods).

```ruby
class GoodDog
end

sparky = GoodDog.new
```

We create an instance of `GoodDog` class and stored it in the variable `sparky`. We now have an object. We say that `sparky` is an object or instance of class `GoodDog`. This workflow of creating a new object or instance from a class is called **instantiation**. We instantiated an object called `sparky` from the class `GoodDog`. An object is returned by calling the class method `new`.

## Modules

Modules are another way to achieve polymorphism. **Module** is a collection of behaviors that is usable in other classes via **mixins**. Module is "mixed-in" to a class using `include` method invocation.

If we wanted `GoodDog` class to have a `speak` method, but we have other classes that we want to use a speak method also, we might do this:

```ruby
module Speak
  def speak(sound)
    puts sound
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!") #=> Arf!
bob = HumanBeing.new
bob.speak("Hello!")  #=> Hello!
```

We have a `module` called Speak. We then `mixin` that module to the `GoodDog` and `HumanBeing` class, using the `include` method.
This allows us to use those methods on objects that instantiated from the `GoodDog` and `HumanBeing` classes.

## Method Lookup

Ruby has a distinct lookup path that it follows each time a method is called. We can use `ancestors` method on any class to find out the method lookup chain.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts ''
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors

---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject
```

`Speak` module is placed in between our custom classes (`GoodDog` and `HumanBeing`) and the `Object` class that comes with Ruby.

`speak` method is not defined in the `GoodDog` class, the next place it looks is the `Speak` module. And so on, linearly, until the method is found or there are no more places to look.

## Exercises

How do we create an object in Ruby? Give an example of creation of an object.

We use `Object.new` to create a new object. We can assign that to a variable.

We create an object by defining a class and instantiating it by using the `.new` method to create an instance AKA an object.

```ruby
class Person
end

dylan = Person.new
```

What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

A module is a way to achieve polymorphism. A collection of behaviors that are usable in other classes via mixins. We can create a module that has methods, which we can then include in other classes, allowing us to call those methods on those particular classes.

```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class Person
  include Speak
end

dylan.speak("hello!") #=> 'hello!'
```

Two reasons to use modules: name spacing and extend functionality

```ruby
module Swimmable
  # the ability to swim
end

class Person
  include Swimmable  # now all the functionality of the Swimmable module is available to the Person class
end                  # we can use Swimmable in other classes as well

first_person = Person.new


###

module Careers
  class Engineer
  end

  class Teacher
  end
end

first_job = Careers::Teacher.new # this is how you instantiate an object within a module

# we understand the relationship better - why are all of these classes in this module? because we're only talking about careers.  We mean teacher and engineer in the career context
```

# Classes and Objects - Part I

## States and Behaviors

We use classes to create objects. When defining a class we focus on two things:

1. States - data associated to an individual object (tracked by instance variables)
2. Behaviors - what objects are capable of doing

Using `GoodDog`, we can create two `GoodDog` objects: `Fido` and `Sparky`. Both are `GoodDog` objects, but may contain different information (height, weight, age, details basically...). Instance variables keep track of this information. Instance variables are scoped at the object (or instance) level and are how objects keep track of their states.

`Fido` and `Sparky` are both objects (or instances) of class `GoodDog`. They contain identical behaviors. Both objects can bark, run, fetch, etc. We define these behaviors as instance methods in a class. Instance methods defined in a class are available to objects (instances) of that class.

Summarize: instance variables keep track of state, instance methods expose behavior for objects.

## Initializing a New Object

```ruby
class GoodDog
  def initialize
    puts "This object was initialized!"
  end
end

sparky = GoodDog.new # => "This object was initialized!"
```

`initialize` gets called every time ou create a new object. Calling the `new` class method leads us to call the `initialize` instance method.

Instantiating a new `GoodDog` object triggered the `initialize` method and resulted in the string being outputted. We refer to `initialize` as a **constructor**, because it's a special method that builds the object when a new object is instantiated. It gets triggered by the `new` class method.

## Instance Variables

We can create new objects and instantiate them with some state, such as a name:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end
end
```

`@name` is an **instance variable**. It exits as long as the object instance exists and it is one of the ways we tie data to objects. It does not "die" after the initialize method is run. It "lives on", to be referenced, until the object instance is destroyed. You can pass argument into `initialize` method through the `new` method.

```ruby
sparky = GoodDog.new("Sparky")
```

The string "Sparky" is being passed from the `new` method through to the initialize method, and is assigned to the local variable `name`. Within the constructor (the `initialize` method), we set the instance variable `@name` to `name`, which results in assigning the string "Sparky" to the `@name` instance variable.

Instance variables keep track of information about the state of an object.

Every object's state is distinct. Instance variables are how we keep track.

## Instance Methods

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
sparky.speak
puts sparky.speak # => Sparky says arf!

fido = GoodDog.new("Fido")
puts fido.speak # => Fido says arf!
```

`fido` can also perform `GoodDog` behaviors. All objects of the same class have the same behaviors, though they contain different states: the name in this case.

Instance method have access to instance variables. So we can use interpolation to add the name of instance `@name` when we call `speak`

## Accessor Methods

If we want to print only `sparky`'s name we can try this:

`puts sparky.name`

But this throws an error:

`NoMethodError: undefined method 'name' for ...`

`NoMethodError` means that the method doesn't exist or is unavailable to that object.

If we want to access the object's name, which is stored in `@name` instance variable, we have to create a method to return it.

Call it `get_name`. It's only job is return the value in `@name` instance variable.

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name  # a "getter" method
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak    # Sparky says arf!
puts sparky.get_name # Sparky
sparky.set_name = "Spartacus"
puts sparky.get_name # Spartacus
```

We call `get_name` a "getter" method. If we want to change `sparky`'s name, we reach for a "setter" method.

Setter methods have special syntax. To use `set_name=`, we would expect to say `spark.set_name=("Spartacus")`.
Ruby allows for more natural syntax and allows us to do this `sparky.set_name = "Spartacus"`

As a convention, we want getters and setter methods named using the same name as the instance variable they are exposing and setting. Like this:

```ruby
class GoodDog
  def initialize(name)
    @name = name
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```

A note: setter methods always return the value that is passed in as an argument, regardless of what happens inside the method. If the setter tries to return something other than the argument's value, it just ignores that attempt.

```ruby
class Dog
  def name=(n)
    @name = n
    "Laddieboy"
  end
end

sparky = Dog.new()
puts(sparky.name = "Sparky") # => "Sparky"
```

Writing getters and setters takes up a lot of space. Ruby give sus a shortcut using **attr_accessor** method:

```ruby
class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name   # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name   # => "Spartacus"
```

Same output above with this refactored code

**attr_accessor** takes a symbol as an argument, which it uses to create the method name for the `getter` and `setter` methods. It replaces two method definitions.

If we only wanted the `getter` without the `setter` we would want to use `attr_reader` method. Works the same, but only allows you to retrieve instance variable. If you only want the setter method, you can use `attr_writer` method. All `attr_*` methods take `Symbol` objects as arguments; if there are more states you're tracking you can use this syntax:

```ruby
attr_accessor :name, :height, :weight
```

### Accessor Methods in Action

With getters and setters, we have a way to expose and change an object's state. We can also use these method from within the class as well.

In previous section, `speak` method reference `@name` instance variable:

```ruby
def speak
  "#{@name} says arf!"
end
```

Instead of referencing the instance variable directly, we want to use the `name` getter method that we created earlier, and that is given to us now by `attr_accessor`. We'll change speak method to this:

```ruby
def speak
  "#{name} says arf!"
```

By removing the `@` symbol, we're now calling the instance method, rather than the instance variable.

You could just reference the instance variable, but it's generally a better practice to call the getter method instead.

For example, we're keeping track of social security numbers in an instance variable called `@ssn`. We don't want to expose the raw data, AKA the entire ssn in our application. Whenever we retrieve it, we want to only display the last 4 digits and mask the rest, like this: "xxx-xx-1234".

If we're referencing the `@ssn` directly, we need to sprinkle our entire class with this code:

```ruby
# converts 123-45-6789 to xxx-xx-6789
'xxx-xx-' + @ssn.split('-').last
```

If we find a bug or need to change the format for whatever reason, it's much easier to just reference a getter method and change it in one place:

```ruby
def ssn
  'xxx-xx-' + @ssn.split('-').last
end
```

Now we use `ssn` instance method (without the `@`) throughout our class to retrieve the ssn. Same with the setter method.

Wherever we're changing the instance variable directly in our class, we should instead use the setter method, but there is a gotcha...

Suppose we added two more states to track the `GoodDog` class called "height" and "weight":

```ruby
attr_accessor :name, :height, :weight
```

This line gives us six getter/setter instance methods: `name`, `name=`, `height`, `height=`, `weight`, `weight=`. It also gives us three instance variables: `@name`, `@height`, `@weight`. Suppose we want ot create a new method that allows us to change several states at once, called `change_info(n, h, w)`. The three arguments to the method correspond to the new name, height, and weight, respectively. Implementation would look like this:

```ruby
def change_info(n, h, w)
  @name = n
  @height = h
  @weight = w
end
```

This is what our code looks like now:

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end
```

Now `change_info` can be used like this:

```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info #=> Sparky weights 10 lbs and is 12 inches tall.
```

We'd like to change the `change_info` method just like when we replaced accessing instance variables with getter methods:

```ruby
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end
```

But now when we try to use the new setter:

```ruby
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info # => Sparky weighs 10 lbs and is 12 inches tall
```

It doesn't work...

### Calling Methods With self

Our setter methods didn't work because Ruby thought we were initializing local variables. Instead of calling `name=`, `height=`, and `weight=` setter methods, we actually created 3 local variables.

To prevent this, we need to use `self.name` to let Ruby know we're calling a method. `change_info` becomes:

```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```

This tells Ruby we're using a setter method, and not creating a local variable. We can use this syntax for getter methods too, but it isn't required:

```ruby
def info
  "#{self.name} weights #{self.weight} and is #{self.height} tall."
end
```

Now if we run the updated `change_info` that uses `self`, our code works.

# Classes and Objects II

## Class Methods

All the methods we created so far are instance methods - they pertain to an instance or object of the class.

We can also define **class methods**. We can call class methods directly on the class itself, without instantiating any objects.

We prepend the method name with the reserved word `self` to define a class method:

```ruby
def self.what_am_i
  "I'm a GoodDog class!"
end
```

Then we can use the class name `GoodDog` followed by the method name like this:

```ruby
GoodDog.what_am_i #=> I'm a GoodDog class!
```

We use class methods to put functionality that does not pertain to individual objects. Objects contain state, and if the method doesn't deal with states, we should use a class method instead of an instance method.

## Class Variables

We can create **class variables** for an entire class. They are created with two `@` symbols `@@`. Here's an example of a class variable and a method to view that variable:

```ruby
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs #=> 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs #=> 2
```

Note that we can access class variables from within an instance method (`initialize` in this case).

## Constants

You can use constants if you want to create a variable that never changes. Use uppercase for the variable name. Technically, constants just need to begin with an uppercase letter, but most Rubyists make it all uppercase.

```ruby
class GoodDog
  DOG_YEARS = 7

  # attr_accessor :name, :age

  def name=(name)
  end

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age # => 28
```

It's possible to reassign a constant, but Ruby throws a warning

## The to_s Method

`to_s` instance method comes built in to every class in Ruby. `puts` anything automatically calls `to_s` on its argument.

`puts sparky # => #<GoodDog:0x007fe542323320>`

`to_s` returns the name of the object's class and an encoding of the object id.

Note: `puts` calls `to_s` for any argument that is not an array. For an array, it writes on separate lines the result of calling `to_s` on each element of the array.

We can add a customer `to_s` to tes this:

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years"
  end
end

puts sparky #=> "This dog's name is Sparky and is 28 in dog years"
```

This overrode the `to_s` instance method with our own `to_s` custom method.

There's another method called `p` that's very similar, but doesn't call `to_s` on its argument. It calls a built in Ruby instance method `inspect`.
`inspect` is useful for debugging and we don't want to override it.

`p sparky         # => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>`

## More About self

So far, we've seen two uses of `self`:

1. Use `self` when calling setter methods from within the class. In our earlier example, we showed that `self` was necessary in order for our `change_info` method to work properly. We had to use `self` to allow Ruby to disambiguate between initializing a local variable and calling a setter method.
2. Use `self` for class method definition

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self #=> #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```

From within the class, when an instance method uses `self`, it references the calling object.

The other place we use self is when defining class methods:

```ruby
class MyAwesomeClass
  def self.this_is_a_class_method
  end
end
```

When `self` is prepended to a method definition, it is defining a **class method**.

Using `self` from inside a class, but outside an instance method refers to the class itself.

So: `def self.a_method` is equal to `def GoodDog.a_method`. Using `self` instead of `GoodDog` is a convention that is useful because if we ever change the class name, we don't have to rename the methods.

In short, `self`'s meaning depends on the context in which it is referenced.

## Exercises

See `.rb` file

# Inheritance

**Inheritance** is when a class **inherits** behavior from another class.

The inheriting class is called the **subclass**
The class it inherits from is the **superclass**

## Class Inheritance

An example of extracting `speak` from `GoodDog` to superclass `Animal`, we use inheritance to make that behavior available to `GoodDog` and `Cat`

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak # => Hello!
puts paws.speak # => Hello!
```

The `<` symbol signifies that `GoodDog` is inheriting from `Animal`. All the methods in `Animal` are now available in `GoodDog` for use.

Same with `Cat`.

What if we want the original `speak` from `GoodDog` class only?:

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak # => Sparky says arf!
puts paws.speak # => Hello!
```

In `GoodDog` we **override** the `speak` method in `Animal` because Ruby checks the object's class first before looking into the superclass.

`Cat` doesn't have its own `speak`, so Ruby checks in the superclass, finds it, and uses that one.

## super

`super` keyword allows you to call methods earlier in the method lookup path. Calling `super` from within a method makes it search the method lookup pathf or a method with the same name, then invokes it.

```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak # => Hello! from GoodDog class
```

We created `Animal` with `speak` instance method. We then created `GoodDog` which "subclasses" `Animal` also with a `speak` instance method to override the inherited `speak`. However, in the subclass' `speak`, we use `super` to invoke `speak` from the superclass.

A more common use of `super` is with `initialize`

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown") # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown"
```

We use `super` with no arguments. However `initialize`, where `super` is being used, takes an argument and changes how `super` is invoked.

`super` automatically forwards the arguments that were passed to the method from which `super` was called. So `super` gets passed `color` from the method in which it was invoked, it then takes `color` argument and passes it to `initialize` in the superclass. As a result, we get an object with two instance variables `@color` and `@name` both set to `brown`.

When called with specific arguments `super(a, b)`, the specified arguments get sent up the method lookup chain:

```ruby
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear") # =>#<BadDog:0x000000014b0ea348 @name="bear", @age=2>
```

Sometimes you need to call `super` with no arguments, in which case you would call it like this: `super()`

You might do that if the superclass method takes no arguments:

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super() # if you call w/o (), you get a wrong num of arguments error, b/c you forward an argument to initialize in the superclass method, which doesn't take an arg
    @color = color
  end
end
```

## Mixing in Modules

Another way to DRY up your code. Extract common methods to a superclass. Superclass is `Animal` that can keep all basic behavior of all animals. Then maybe a `Mammal` subclass of `Animal`. Maybe `Cat` and `Dog` are subclasses of `Mammal`. Hierarchy.

The goal is to put the right behaviors (methods) in the right classes so we don't need to repeat code in multiple classes.

All fish can swim so maybe `swim` method should be included in the `Fish` class. All mammals have warm blood, so maybe `warm_blooded?` is a method in `Mammal`. That way you can call `warm_blooded?` on any `Dog` or `Cat` objects and have it return `true`.

This model works, but there are some exceptions. For example, `swim` is in `Fish`, but some mammals can swim as well. We don't want to move `swim` into `Animal` because not all animals can swim, and we don't want to create another `swim` in `Dog` because we don't want to repeat ourselves.

For concerns such as the above, we can group them into a model and then **mix in** that model to the classes that require those behaviors:

```ruby
module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal ; end

class Fish < Animal
  include Swimmable # mix in Swimmable module
end

class Mammal < Animal
end

class Cat < Mammal
end

class Dog < Mammal
  include Swimmable # mix in Swimmable module
end

sparky = Dog.new
neemo = Fish.new
paws = Cat.new

sparky.swim # => I'm swimming
neemo.swim # => I'm swimming
paws.swim # => NoMethodError: undefined method 'swim' for Cat object
```

Use modules to group common behaviors.

Side note: the suffix "able" on a verb describes the behavior tha the module is modeling. This is used in the `Swimmable` module. Similarly, we would name a "walking" module as `Walkable`. This is common practice when naming modules.

## Inheritance vs Modules

Two primary ways Ruby implements inheritance:

1. Class inheritance - this is what you would traditionally think of for inheritance
2. Interface inheritance - this is where mixin modules come into play

When to use one vs the other:

- You can only subclass (inheritance) from one class. You can mix in as many modules as you want
- If there is an "is-a" relationship, class inheritance makes sense. If there is a "has-a" relationship, interface inheritance is better.
  - Dog "is an" animal and it "has an" ability to swim.
- You can't instantiate modules. You cannot create objects from modules.

## Method Lookup Path

The order in which classes are inspected when you call a method. Example code:

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing"
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

puts "---Animal method lookup---"
puts Animal.ancestors

# => ---Animal method lookup---
# => Animal
# => Walkable
# => Object
# => Kernel
# => BasicObject
```

When we call a method of `Animal`, Ruby looks in the `Animal` class first, then the `Walkable` module, then the `Object` class, then the `Kernel` module, finally the `BasicObject` class.

```ruby
fido = Animal.new
fido.speak # => I'm an animal, and I speak!
```

Ruby found `speak` in the `Animal` class and looked no further

`fido.walk #=> I'm walking!`

Ruby looked for `walk` in `Animal` then in `Walkable`.

`fido.swim #=> NoMethodError`

Ruby couldn't find a `swim` method.

Let's add another class that inherits from `Animal` and mix in the `Swimmable` and `Climbable` module:

```ruby
class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors

# =>
---GoodDog method lookup---
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
```

- Ruby looks in the last module we included first. If module methods contain the same name, the last module we included will be consulted first
- The superclass module is on the lookup path. GoodDog objects have access to `Walkable` methods.

## More Modules

Two more uses for modules besides mix-ins.

First is called **namespacing**. Namespacing means organizing similar classes under a module. We use modules to group related classes. That is the first advantage of using modules for namespacing. It's easy for us to recognize related classes in our code. Second advantage is it reduces the likelihood of our classes colliding with other similarly named classes in our codebase. Here's what it looks like:

```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end

buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!') # => Arf!
kitty.say_name('kitty') # => kitty
```

We can call classes in a module by appending the class name to the module name with two colons

The second use case for modules is using modules as a **container** for methods. This involves using modules to house other methods.

Useful for methods that seem out of place in your code.

```ruby
module Mammal
   #...

   def self.some_out_of_place_method(num)
     num * 2
   end
end
```

If you define methods this way within a module, you can call them directly from the module:

`value = Mammal.some_out_of_place_method(4)`

Alternately, you can use this syntax:

`value = Mammal::some_out_of_place_method(4)`

But the former is preferred.

## Private, Protected, and Public

Method Access Control. Access Control is a concept that exists in a number of programming languages, including Ruby. Generally implemented through access modifiers. An access modifier allows to restricts access to a particular thing. The things we are concerned with restricting access to are methods defined in a class. Therefore, in a Ruby context, this context is usually referred to as Method Access Control.

Method Access Control (or access modifiers) is implemented in Ruby through use of `public`, `private`, and `protected` access modifiers.

Right now, all methods in GoodDog class are public methods.

**Public methods** are methods that are available to anyone who knows either the class name or the object's name. They are available for the rest of the program to use and comprise the class's interface (that's how other classes and objects will interact with this class and its objects).

**Private methods** are methods that can do things in the class, but don't need to be available to the rest of the program. To define a private method we use the `private` method call. This makes anything below private, unless we call another method like `protected` to negate it.

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
sparky.human_years # NoMethodError: private method `human_years` called for
```

So what's the point of private methods if we can't use them?

They can be used from other methods in the class. Like so:

```ruby
# This is above the private methods, it's public
def public_disclosure
  "#{self.name} in human years is #{human_years}"
end
```

So we can have a public method that calls a private method in the same class to get some value.

Public and private methods are the most common, but sometimes we want an in between approach. For this we use `protected` to create **protected methods**.

They are similar to private methods in that they cannot be invoked outside the class. Main difference is that the protected methods allow access between class instances, while private do not.

## Accidental Method Overriding

Every class you create inherently subclasses from `class Object`. `Object` class is built into Ruby and comes with critical methods.

```ruby
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

Parent.superclass # => Object
```

Methods defined in `Object` are available in _all classes_.

A subclass can override a superclass's methods.

```ruby
class Child < Parent
  def say_hi
    p "Hi from Child."
  end
end

child = Child.new
child.say_hi #=> "Hi from Child"
```

This means that it's possible to override a method that was originally defined in `Object`.

Here's an example with `send`. `send` is an instance method that serves as a way to call a method by passing it a symbol or a string which represents the method you want to call.

```ruby
son = Child.new
son.send :say_hi #=> "Hi from Child."
```

```ruby
class Child
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end
end

lad = Child.new
lad.send :say_hi # => wrong number of arguments --> this is because you defined your own `send` that doesn't take arguments
```

Another example with `instance_of?`. This method returns `true` if an object is an instance of a given class, `false` otherwise.

```ruby
c = Child.new
c.instance_of? Child #=> true
c.instance_of Parent #=> false
```

```ruby
class Child
  def instance_of?
    p "I am a fake instance"
  end
end

heir = Child.new
heir.instance_of? Child # => wrong number of arguments because our custom `instance_of?` doesn't take arguments...
```

With all that said, `to_s` is easily overridden without any major side effects. You normally want to do this when you want a different string representation of an object.

It's important to not override methods.

# Attributes (FIRST NON-BOOK SECTION OF NOTES)

Terms are sometimes grey in programming. Some terms have different meanings in different contexts, some people don't agree on certain term meanings.

'Attributes' are different characteristics that make up an object. They can be accessed and manipulated outside an object. Sometimes, we might just be referring to the characteristic names, or the names and values. Depends on context.

Attribute implementation varies based on programming language. JS is a little more clear, you just set the property in an object.

It's more involved in Ruby. Getters, setters, initialize...

Defining attributes in this strict way (instance variables with accessor methods) leads to complications.

- Is it an attribute if the accessor method is private? (AKA no getter, can't access outside of the class)
- What if there's a setter, but no getter?
- Vice versa?

The word **attributes** gets thrown around loosely, but generally refers to **instance variables**. Most of the time these objects have accessor methods (because they are more useful with them), but they aren't strictly necessary for our definition of the word attributes.

Classes define the attributes of its objects == classes specify the names of instance variables each object should have (what the object should be made of).

State tracks attributes for individual objects == object's state is composed of instance variables and their values - we're not referring to getters or setters.

TLDR: attributes are instance variables. They usually have accessor methods.
