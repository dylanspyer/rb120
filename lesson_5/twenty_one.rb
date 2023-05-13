module Formatable
  SUIT_KEY = { 'H' => '♥', 'D' => '♦', 'C' => '♣', 'S' => '♠' }

  def convert_suit(suit)
    SUIT_KEY[suit] || ' '
  end

  def collect_card_lines(hand)
    hand.map do |card|
      display_formatted_card(card).map do |line|
        line + ' '
      end
    end
  end

  def display_formatted_hand(hand)
    lines = collect_card_lines(hand)
    str = ''
    (0..10).each do |idx|
      str = ''
      lines.each.with_index do |_, card_idx|
        str += lines[card_idx][idx]
      end
      puts str
    end
  end

  def display_formatted_card(card)
    card_suit = convert_suit(card.suit)
    case card.name.size
    when 1
      display_card_template(card, card_suit)
    when 2
      display_ten_template(card, card_suit)
    end
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Layout/ArrayAlignment
  # rubocop: disable Layout/SpaceInsideArrayLiteralBrackets
  def display_card_template(card, card_suit)
    [ "+-----------+",
    "| #{card_suit}         |",
    "|           |",
    "|           |",
    "|           |",
    "|     #{card.name}     |",
    "|           |",
    "|           |",
    "|           |",
    "|         #{card_suit} |",
    "+-----------+" ]
  end

  def display_ten_template(card, card_suit)
    ["+-----------+",
    "| #{card_suit}         |",
    "|           |",
    "|           |",
    "|           |",
    "|    #{card.name}     |",
    "|           |",
    "|           |",
    "|           |",
    "|         #{card_suit} |",
    "+-----------+"]
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Layout/ArrayAlignment
  # rubocop: enable Layout/SpaceInsideArrayLiteralBrackets

  def join_word(hand_or_card)
    if hand_or_card.class == Array
      ['A', '8'].include?(hand_or_card[-1].name) ? 'an' : 'a'
    elsif hand_or_card.class == Card
      ['A', '8'].include?(hand_or_card.name) ? 'an' : 'a'
    end
  end

  def list_cards(hand)
    join_word = join_word(hand)
    last_card = hand[-1]
    first_cards = hand[0..-2].join(', ')
    puts "#{self.class} has a #{first_cards} and #{join_word} #{last_card}."
  end
end

module Displayable
  def display_goodbye_message
    puts "Thanks for playing Twenty one!"
    puts "Goodbye!"
  end

  def display_total
    puts "#{self.class} has a total of #{calculate_hand_total!}"
  end

  def display_push
    puts "It's a tie!"
  end

  def display_player_wins
    puts "You won!"
  end

  def display_dealer_wins
    puts "The dealer won!"
  end

  def display_welcome_message
    clear
    puts "Welcome to Twenty One"
    puts "Try to get as close to 21 without going over"
    puts "Cards are worth their face value in points"
    puts "Face cards are worth 10"
    puts "Aces are worth 1 or 11"
    puts "The dealer will keep hitting if they are below 17"
    puts "Good luck! Press enter to start playing!"
    gets
    clear
  end
end

class Participant
  attr_accessor :hand, :total

  include Displayable

  def initialize
    @hand = []
    @total = 0
  end

  def determine_ace_value!(unadjusted_ace_total)
    hand.each do |card|
      if card.name == 'A' && unadjusted_ace_total > 21
        card.value = 1
      end
    end
  end

  def calculate_hand_total!
    unadjusted_ace_total = 0
    hand.each { |card| unadjusted_ace_total += card.value }
    determine_ace_value!(unadjusted_ace_total)
    adjusted_ace_total = 0
    hand.each { |card| adjusted_ace_total += card.value }
    adjusted_ace_total
  end

  def bust?
    calculate_hand_total! > 21
  end

  def twenty_one?
    calculate_hand_total! == 21
  end

  def show_cards
    list_cards(hand)
    display_formatted_hand(hand)
  end
end

class Player < Participant
  include Formatable

  def initialize
    super
  end
end

class Dealer < Participant
  include Formatable

  def initialize(deck, player_hand)
    @deck = deck.cards
    @player_hand = player_hand
    super()
  end

  def deal_card!(participant_hand)
    i = (0...@deck.size).to_a.sample
    participant_hand << @deck.delete_at(i)
  end

  def deal_starting_cards!
    2.times { deal_card!(@player_hand) }
    2.times { deal_card!(@hand) }
  end

  def show_card
    temp_hand = [@hand[0]]
    temp_hand << Card.new(" ", " ")
    dealer_up_card = temp_hand[0]
    puts "Dealer has #{join_word(dealer_up_card)} #{dealer_up_card}"
    display_formatted_hand(temp_hand)
  end

  def stays?
    bust? ||
      twenty_one? ||
      calculate_hand_total! > 17
  end
end

class Card
  attr_accessor :value
  attr_reader :name, :suit

  SUIT = ['H', 'D', 'S', 'C']
  FACE = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  NAME_KEY = { 'J' => 'Jack', 'Q' => 'Queen', 'K' => 'King', 'A' => 'Ace' }

  def initialize(face, suit)
    @name = face
    @suit = suit
    @value = convert_to_value(face)
  end

  def to_s
    "#{convert_name} of #{convert_suit}"
  end

  def convert_name
    NAME_KEY[name] || name
  end

  def convert_suit
    case suit
    when 'H'
      'Hearts'
    when 'D'
      'Diamonds'
    when 'S'
      'Spades'
    when 'C'
      'Clubs'
    end
  end

  private

  def convert_to_value(face)
    if face.to_i > 0
      face.to_i
    elsif face.to_i == 0 && face != 'A'
      10
    else
      11
    end
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    make_deck!
  end

  private

  def make_deck!
    Card::SUIT.each do |suit|
      Card::FACE.each do |face|
        @cards << Card.new(face, suit)
      end
    end
  end
end

class TwentyOneGame
  include Displayable

  def initialize
    @player = Player.new
    @deck = Deck.new
    @dealer = Dealer.new(@deck, player.hand)
  end

  def show_initial_cards
    dealer.show_card
    player.show_cards
  end

  def prompt_hit_or_stay
    answer = nil
    loop do
      puts "Do you want to hit or stay?"
      answer = gets.chomp.downcase
      break if answer.start_with?('h') || answer.start_with?('s')
    end
    answer = answer.start_with?('h') ? 'hit' : 'stay'
  end

  def player_wins?(player_ttl, dealer_ttl)
    dealer.bust? && player.bust? == false ||
      player_ttl > dealer_ttl && player.bust? == false
  end

  def push?
    dealer.calculate_hand_total! == player.calculate_hand_total!
  end

  def show_result
    plyr_ttl = player.calculate_hand_total!
    dlr_ttl = dealer.calculate_hand_total!
    return display_push if push?
    player_wins?(plyr_ttl, dlr_ttl) ? display_player_wins : display_dealer_wins
  end

  def clear
    system 'clear'
  end

  def pause
    puts "Press enter to see what happens next"
    gets
  end

  def player_turn
    loop do
      player.display_total
      break if player.bust? || player.twenty_one?
      answer = prompt_hit_or_stay
      clear
      break if answer == 'stay'
      dealer.deal_card!(player.hand)
      show_initial_cards
    end
  end

  def dealer_turn
    loop do
      clear
      dealer.show_cards
      dealer.display_total
      player.show_cards
      player.display_total
      break if dealer.stays?
      dealer.deal_card!(dealer.hand)
      pause
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      break if answer.start_with?('y') || answer.start_with?('n')
      puts "Invalid input. Please choose y or n."
    end
    answer == 'y'
  end

  def main_game
    dealer.deal_starting_cards!
    show_initial_cards
    player_turn
    dealer_turn if player.bust? == false
    pause
    show_result
  end

  def start
    display_welcome_message
    clear
    loop do
      main_game
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  private

  def reset
    self.deck = Deck.new
    player.hand.clear
    dealer.hand.clear
    player.total = 0
    dealer.total = 0
    clear
  end

  attr_reader :dealer, :player
  attr_writer :cards, :deck
end

TwentyOneGame.new.start
