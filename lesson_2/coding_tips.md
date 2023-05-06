# Coding Tips

## Problem before design

Use a **spike**, exploratory code to play around with the problem. Validate hunches.
Don't worry about quality at this point - spikes are meant to be thrown away.

## Repetitive nouns in method names are a sign you're missing a class

In RPS, we find ourselves referring to a `move` constantly. That means we probably should put `move` into a class `Move`.
Suppose we had:

```ruby
human.make_move
computer.make_move

puts "Human move was #{format_move(human.move)}."
puts "Computer move was #{format_move(computer.move)}."

if compare_moves(human.move, computer.move) > 1
  puts "Human won!"
elsif compare_moves(human.move, computer.move) < 1
  puts "Computer won!"
else
  puts "It's a tie!"
end
```

Compared to this:

```ruby
human.move!
computer.move!

puts "Human move was #{human.move.display}."
puts "Computer move was #{computer.move.display}."

if human.move > computer.move
  puts "Human won!"
elsif human.move < computer.move
  puts "Computer won!"
else
  puts "It's a tie!"
end
```

## When naming methods, don't include the class name

Lots of beginners do this:

```ruby
class Player
  def player_info
    # returns player's name, move and other data
  end
end
```

Then when we want to call `Player#player_info`, it looks like this:

```ruby
player1 = Player.new
player2 = Player.new

puts player1.player_info
puts player2.player_info
```

Very unnatural and redundant. Rather, just call the method `info` and then we can refer like this:

```ruby
puts player1.info
puts player2.info
```

## Avoid long method invocation chains

Don't do stuff like this:
`human.move.display.size`

3 chain method invocation. If anything changes or returns `nil`, it breaks and it's hard to debug because it's going to be a buried `nil`.

Maybe if a method could return `nil` you do this:

```ruby
move = human.move
puts move.display.size if move
```

## Avoid design patterns for now

Don't worry about best practices for now.
