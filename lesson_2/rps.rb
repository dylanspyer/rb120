module Displayable
  def display_welcome_message
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "The score is human: #{human.score} to computer: #{computer.score}."
  end

  def display_game_over
    winner = human.score > computer.score ? human.name : computer.name
    puts "Game over! #{winner} won!"
  end

  def display_move_log(history)
    system 'clear'
    history.move_log.each do |player, moves|
      puts "#{player.capitalize} has played the following moves:"
      moves.each do |move|
        puts move.capitalize
      end
    end
  end

  def display_sequence
    display_moves
    display_winner
  end

  def display_move_prompt
    puts "Please choose rock, paper, scissors, lizard, spock."
    puts "Type `history` to view the move history."
  end
end

module Scoreable
  def set_play_to_score
    play_to_score = nil
    loop do
      puts "What score do you want to play to? (Enter a number from 1-10)."
      play_to_score = gets.chomp.to_i
      break if (1..10).include?(play_to_score)
    end
    self.play_to_score = play_to_score
    @@play_to_score = play_to_score
    system 'clear'
  end

  # wasn't sure about using a class variable here (ln 243)
  # feels wrong because I'm only using it for Calculon
  # but I wasn't sure how else to accomplish Calc's feature
  def update_score
    if human.move > computer.move
      human.score += 1
      Human.score += 1
    elsif human.move < computer.move
      computer.score += 1
      Human.score += 1
    end
  end

  def reset_scores
    Human.score = 0
    human.score = 0
    computer.score = 0
  end

  def start_game_score_sequence
    reset_scores
    set_play_to_score
  end

  def score_sequence
    update_score
    display_score
  end
end

class Move
  attr_accessor :value

  WIN_KEY = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'lizard' => ['paper', 'spock'],
    'spock' => ['scissors', 'rock']
  }

  ABBREVIATION_KEY = {
    'r' => 'rock',
    'p' => 'paper',
    'sc' => 'scissors',
    'l' => 'lizard',
    'sp' => 'spock',
    'h' => 'history',
    'history' => 'history'
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    Move::WIN_KEY[value].include?(other_move.value)
  end

  def <(other_move)
    Move::WIN_KEY[other_move.value].include?(value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  include Displayable
  @@human_move = ''
  @@human_score = 0

  def self.move
    @@human_move
  end

  def self.score
    @@human_score
  end

  def self.score=(score)
    @@human_score = score
  end

  def set_name
    system 'clear'
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def show_history?(choice, history)
    showed_history = false
    if choice == 'history'
      display_move_log(history)
      showed_history = true
    end
    showed_history
  end

  def choose(history)
    choice = nil
    loop do
      display_move_prompt
      choice = Move::ABBREVIATION_KEY[gets.chomp.downcase]
      next if show_history?(choice, history)
      break if Move::WIN_KEY.keys.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    @@human_move = move.value
  end
end

class Computer < Player
  def choose
    self.move = Move.new(Move::WIN_KEY.keys.sample)
  end

  def winning_move
    value = Move::WIN_KEY.values.select do |sub_arr|
      sub_arr.include?(Human.move)
    end.sample
    Move::WIN_KEY.key(value)
  end

  def losing_move
    Move::WIN_KEY[Human.move].sample
  end
end

class Clamps < Computer # always chooses 'scissors'
  def set_name
    @name = 'Clamps'
  end

  def choose
    self.move = Move.new('scissors')
  end
end

class Bender < Computer # standard opponent
  def set_name
    @name = 'Bender'
  end
end

class Beelzebot < Computer # always lets you win
  def set_name
    @name = 'Beelzebot'
  end

  def choose
    self.move = Move.new(losing_move)
  end
end

class Calculon < Computer # let's you get close to winning,
  def set_name            # and then wins in dramatic fashion
    @name = 'Calculon'
  end

  def choose
    self.move = if Human.score < RPSGame.play_to_score - 1
                  Move.new(losing_move)
                else
                  Move.new(winning_move)
                end
  end
end

class HedonismBot < Computer # cheater
  def set_name
    @name = 'Hedonismbot'
  end

  def choose
    self.move = Move.new(winning_move)
  end
end

class History
  attr_accessor :move_log

  def initialize
    @move_log = { 'human' => [], 'computer' => [] }
  end

  def log_move!(player, move)
    move_log[player] << move.value
  end
end

class RPSGame
  attr_accessor :human, :computer, :play_to_score, :history

  OPPONENTS = {
    'Clamps' => Clamps.new,
    'Bender' => Bender.new,
    'Beelzebot' => Beelzebot.new,
    'Calculon' => Calculon.new,
    'HedonismBot' => HedonismBot.new
  }

  @@play_to_score = 0

  include Displayable
  include Scoreable

  def initialize
    @human = Human.new
    @computer = prompt_choose_opponent
    @history = History.new
  end
  # would it make sense to have this be a module instead?
  # maybe I could treat this the same way as "Scoreable" -
  # module or collaborator object -
  # wasn't sure which made more sense in this context
  # is consistency more important here?

  def self.play_to_score
    @@play_to_score
  end

  def list_opponents
    bots = ['Clamps', 'Bender', 'Beelzebot', 'Calculon', 'HedonismBot']
    bots.each.with_index do |bot, i|
      i += 1
      puts "#{i}: #{bot}"
    end
  end

  def prompt_choose_opponent
    system 'clear'
    bot = nil
    loop do
      puts "Choose an opponent by pressing the corresponding number:"
      bots = list_opponents
      bot = bots[gets.chomp.to_i - 1]
      break if bots.include?(bot)
      puts "Invalid input, please try pressing a number from 1 to 5."
    end
    choose_opponent(bot)
  end

  def choose_opponent(opponent)
    self.computer = OPPONENTS[opponent]
  end

  def choose_move_sequence
    human.choose(history)
    history.log_move!('human', human.move)
    computer.choose
    history.log_move!('computer', computer.move)
  end

  def game_over?
    human.score == play_to_score || computer.score == play_to_score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def game_over_sequence?
    display_game_over
    play_again = false
    if play_again?
      prompt_choose_opponent
      play_again = true
    end
    play_again
  end

  def play_game?
    choose_move_sequence
    display_sequence
    score_sequence
    game_over?
  end

  def play
    display_welcome_message
    loop do
      start_game_score_sequence
      loop do
        break if play_game?
      end
      next if game_over_sequence?
      break
    end
    display_goodbye_message
  end
end
# I extracted the methods in `play` quite a bit to appease Rubocop.
# Does this make the code harder to read?

RPSGame.new.play
