module Formatable
  def clear_screen_and_display_board
    clear
    display_board
  end

  def format_choices
    unmarked_sqrs_arr = board.unmarked_keys
    join_word = case unmarked_sqrs_arr.size
                when 1
                  ''
                when 2
                  ' and '
                else
                  ' or '
                end
    unmarked_sqrs_arr[0..-2].join(', ') + join_word + unmarked_sqrs_arr[-1].to_s
  end

  def clear
    system 'clear'
  end
end

module Displayable
  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "Today's match is #{human.name} against #{computer.name}!"
    puts "We'll be playing until someone wins 3 rounds!"
    puts "To choose a square, press the corresponding number"
    puts "Press enter to see an example"
    gets
    display_sample_board
    puts ""
  end

  # rubocop: disable Metrics/MethodLength
  def display_sample_board
    puts "     |     |"
    puts "  1  |  2  |  3"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  4  |  5  |  6"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  7  |  8  |  9"
    puts "     |     |"
  end
  # rubocop: enable Metrics/MethodLength

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def display_result
    display_board
    case who_won
    when human
      puts "#{human.name} won!"
    when computer
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def display_score
    puts "The score is now:"
    puts "=> #{human.name}: #{human.score}"
    puts "=> #{computer.name}: #{computer.score}"
  end

  def display_game_winner
    case who_won
    when human
      puts "#{human.name} won 3. #{human.name} wins the game!"
    when computer
      puts "#{computer.name} won 3. #{computer.name} wins the game!"
    end
  end
end

class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def identify_at_risk_square
    at_risk_squares_hsh = {}
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers?(squares)
        sq_num = @squares.key(squares.select(&:unmarked?).first)
        marker = line.map { |num| @squares[num].marker }.max
        at_risk_squares_hsh[marker] = sq_num
      end
    end
    at_risk_squares_hsh
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def two_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 2
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :name, :score, :board

  include Formatable

  def initialize(board)
    @score = 0
    @board = board
  end

  def increment_score
    self.score += 1
  end
end

class Human < Player
  def initialize(board)
    @marker = choose_marker
    @name = choose_name
    super
  end

  def choose_marker
    marker = nil
    loop do
      puts "Do you want to be X or O?"
      marker = gets.chomp.upcase
      break if ['X', 'O'].include?(marker)
      puts "Sorry, that's not a valid input. Please choose X or O."
    end
    self.marker = marker
  end

  def moves
    puts "Choose a square (#{format_choices}): "
    sqr = nil
    loop do
      sqr = gets.chomp.to_f
      break if board.unmarked_keys.include?(sqr.to_i) && sqr.to_i == sqr
      puts "Sorry, that's not a valid choice."
    end

    board[sqr.to_i] = marker
  end

  private

  def invalid_name?
    if name.chars.all? { |char| char == ' ' }
      puts "Try another name"
      return true
    end
    false
  end

  def display_name_again_message
    puts "Sounds like you're unhappy with that name. Let's try again!"
    puts "What is your name?"
  end

  def prompt_answer
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if answer.start_with?('y') || answer.start_with?('n')
      puts "Invalid input, please type y or n."
    end
    answer
  end

  def choose_name
    puts "What is your name?"
    loop do
      self.name = gets.chomp.capitalize.strip
      next if invalid_name?
      puts "Okay, #{name}! Is that correct? (y/n to continue)"
      prompt_answer.start_with?('y') ? break : display_name_again_message
    end
    name.strip
  end
end

class Computer < Player
  attr_reader :board

  def initialize(human_marker, board)
    @marker = assign_marker(human_marker)
    @name = assign_name
    super(board)
  end

  def assign_name
    names = ['Ricky Bobby', 'Ryan Gosling', 'Jack Black',
             'Nancy Kerrigan', 'Louis Griffin', 'Kate Spade', 'Michelle Obama']

    self.name = names.sample
  end

  def assign_marker(human_marker)
    self.marker = human_marker == 'X' ? 'O' : 'X'
  end

  def choose_best_move
    best_move = determine_critical_moves(board.identify_at_risk_square)
    if best_move
      best_move
    elsif middle_square
      middle_square
    end
  end

  def choose_random_move
    board.unmarked_keys.sample
  end

  def middle_square
    middle = board.squares[5]
    middle.marker == ' ' ? 5 : nil
  end

  def moves
    if choose_best_move
      board[choose_best_move] = marker
    elsif middle_square
      board[middle_square] = marker
    else
      board[choose_random_move] = marker
    end
  end

  def determine_critical_moves(at_risk_squares_hsh)
    computer_wins = nil
    block_human = nil
    at_risk_squares_hsh.each do |marker, sq_num|
      if marker != self.marker && marker != ' '
        block_human = sq_num
      elsif marker == self.marker
        computer_wins = sq_num
      end
    end
    computer_wins || block_human
  end
end

class TTTGame
  attr_reader :board, :human, :computer, :current_marker

  include Formatable
  include Displayable

  def initialize
    clear
    @board = Board.new
    @human = Human.new(board)
    @computer = Computer.new(human.marker, board)
    @current_marker = prompt_who_goes_first
  end

  def play
    clear
    display_welcome_message
    loop do
      main_game
      display_game_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def main_game
    loop do
      display_board
      player_move
      display_result
      keep_score
      break if game_over?
      reset
      display_play_again_message
    end
  end

  def game_over?
    human.score == 3 || computer.score == 3
  end

  def reset_player_scores
    human.score = 0
    computer.score = 0
  end

  def keep_score
    case who_won
    when human
      human.increment_score
    when computer
      computer.increment_score
    end
    display_score
  end

  def who_won
    case board.winning_marker
    when human.marker
      human
    when computer.marker
      computer
    end
  end

  def ask_who_goes_first(human_name, computer_name)
    puts "Who goes first? #{human_name} or #{computer_name}?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if [human_name.downcase, computer_name.downcase].include?(answer)
      puts "Invalid input, please type #{human_name} or #{computer_name}."
    end
    answer
  end

  def assign_current_marker(player)
    case player
    when human.name.downcase
      human.marker
    when computer.name.downcase
      computer.marker
    end
  end

  def prompt_who_goes_first
    player = ask_who_goes_first(human.name, computer.name)
    assign_current_marker(player)
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def prompt_play_again_answer
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end
    answer
  end

  def play_again?
    answer = prompt_play_again_answer
    if answer == 'y'
      reset
      true
    else
      false
    end
  end

  def reset
    board.reset
    human.marker = human.choose_marker
    computer.marker = computer.assign_marker(human.marker)
    @current_marker = prompt_who_goes_first
    reset_player_scores if game_over?
    clear
  end

  def current_player_moves
    if @current_marker == human.marker
      human.moves
      @current_marker = computer.marker
    else
      computer.moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end
end

game = TTTGame.new
game.play
