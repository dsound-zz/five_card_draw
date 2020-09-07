SUITS = [:spades, :diamonds, :hearts, :clubs]
VALUES = (1..13).to_a
FACES = ["Jack", "Queen", "King", "Ace"]

class Card
  attr_accessor :suit, :value
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  
  def to_s
    suit = @suit.to_s.capitalize
    if @value >= 0 && @value < 10
      "#{@value + 1} of #{suit}"
    else
      "#{FACES[@value - 10]} of #{suit}"
    end
  end
end

class Hand
  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end
  
  def beats?(other)
   score > other.score
  end

  def score
    unit = 1000
    total = 0
    total += unit * 10 if is_straight && is_flush
    total += unit * 8 if of_a_kind == 4
    total += unit * 7 if is_full_house
    total += unit * 6 if is_flush
    total += unit * 5 if is_straight
    total += unit * 4 if !is_full_house && of_a_kind == 3
    total += unit * 3 if is_two_pair
    total += unit * 2 if !is_two_pair && of_a_kind == 2
    if total >= 2000
      total += total_value
    end
    total += high_card.value
    total
  end

  def is_full_house
    values = @cards.group_by(&:value).values
    values.length == 2 && values.all? {|v| [2,3].include? v}
  end

  def is_flush
    by_value = @cards.sort_by(&:value).map(&:suit).uniq.length == 1
  end

  def is_straight
    last_card = nil
    differences = []
    @cards.sort_by(&:value).each do |card| 
      if last_card
        differences.push(card.value - last_card.value)
      end
      last_card = card
    end
    differences.uniq.length == 1 && differences.first == 1
  end

  def is_two_pair
    values = @cards.group_by(&:value).values.sort_by(&:length)
    values.length == 3 && values.last.length == 2
  end
  
  def of_a_kind
    pairs_up = @cards.group_by(&:value).values.sort_by(&:length).filter{|g| g.length > 1}
    pairs_up.last && pairs_up.last.length
  end
  
  def total_value
    @cards.map(&:value).reduce(:+)
  end
  
  def high_card
    @cards.sort_by(&:value).last
  end

end

class Deck
  attr_reader :cards
  
  def initialize
    @cards = SUITS.flat_map do |suit|
      VALUES.map do |value| 
        Card.new(suit, value)
      end
    end
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def draw(amount)
    cards.pop(amount)
  end
end



