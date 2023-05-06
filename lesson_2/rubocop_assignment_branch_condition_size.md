# Rubocop: Assignment Branch Condition Size

Always examine any complexity complaints Rubocop issues and refactor to simplify.

Addressing Assignment Branch Condition (AbcSize) complaints is difficult.

First, identify the characteristics of the method that triggered AbcSize complaint.

To do that, you need to understand how to calculate AbcSize for a method...(don't need to memorize, just understand and bookmark)

# Definition

AbcSize COP is a code complexity warning that counts the assignments, branches (method calls), and conditions in a method, then reduces those numbers to a single value - a metric - that describes the complexity (larger AbcSize == more complex code).

Rubocop counts the assignments (we'll call this `a`), branches (`b`) and conditions (`c`) in your method. Then it computes it with this formula:
`abc_size = Math.sqrt(a**2 + b**2 + c**2)`
If the result is greater than `18`, Rubocop flags as too complex.

Tip: focus on the component with the greatest count.

Replacing conditions is easy. Just extract it to a method:

`if move1 == "rock" && (move2 == "scissors" || move2 == "lizard")...`

Can be rewritten as:

```ruby
def rock_wins?(move1, move2)
  move1 == "rock" && (move2 == "scissors" || move2 == "lizard")
end

if rock_wins?(move1, move2)...
```

# Branches

Counting branches (method calls) can be tricky. Ruby hides method calls behind syntax (think about calls to getters).

There's also `+`, `*` `>`, all don't necessarily look like method calls, but they are.
