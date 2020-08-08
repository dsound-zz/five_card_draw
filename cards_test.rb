require 'minitest/autorun'
require './cards'
require 'pry'

describe "A deck of cards" do
  let(:deck) { Deck.new() }
  it "has 52 cards" do
    value(deck.cards.length).must_equal(52)
  end
  it "shuffles" do
    original_order = deck.cards.map(&:value)
    deck.shuffle
    value(deck.cards.map(&:value)).wont_equal(original_order)
  end
end

# describe "A hand of cards" do
#   def h(*args)
#     Hand.new(args.map { |c| Card.new(*c) })
#   end
#   let (:hands) {
#     {
#       royal_flush: h([:spades, 13], [:spades, 12], [:spades, 11], [:spades, 10], [:spades, 9]),
#       straight_flush: h([:spades, 1], [:spades, 2], [:spades, 3], [:spades, 4], [:spades, 5]),
#       full_house: h([:spades, 8], [:hearts, 8], [:diamonds, 8], [:spades, 7], [:clubs, 7]),
#       flush: h([:spades, 1], [:spades, 5], [:spades, 9], [:spades, 10], [:spades, 4]),
#       straight: h([:spades, 8], [:hearts, 5], [:spades, 6], [:spades, 7], [:spades, 4]),
#       three_of_kind: h([:hearts, 5], [:spades, 5], [:clubs, 5], [:clubs, 1], [:diamonds, 3]),
#       two_pair: h([:hearts, 5], [:spades, 5], [:clubs, 2], [:clubs, 1], [:diamonds, 1]),
#       pair: h([:hearts, 5], [:spades, 5], [:clubs, 3], [:clubs, 1], [:diamonds, 2]),
#       high_card: h([:hearts, 5], [:spades, 4], [:clubs, 13], [:clubs, 1], [:diamonds, 2]),
#       nothing: h([:hearts, 5], [:spades, 4], [:clubs, 1], [:clubs, 8], [:diamonds, 2])
#     }
#   }
#   def self.beats(hand, others)
#     others.each do |other| 
#       it "#{hand} must beat #{other}" do
#         value(hands[hand].score).must_be :>, hands[other].score
#       end
#     end
    
# sorted_hand_2 = hand2.hand.map { |h| h.suit.push(h.value) }

#   end
#   beats(:royal_flush, [:straight_flush, :full_house, :flush, :straight, :three_of_kind, :two_pair, :pair, :high_card, :nothing])
#   beats(:straight_flush, [:full_house, :flush, :straight, :three_of_kind, :two_pair, :pair, :high_card, :nothing])
#   beats(:full_house, [:flush, :straight, :three_of_kind, :two_pair, :pair, :high_card, :nothing])
#   beats(:flush, [:straight, :three_of_kind, :two_pair, :pair, :high_card, :nothing])
#   beats(:straight, [:three_of_kind, :two_pair, :pair, :high_card, :nothing])
#   beats(:three_of_kind, [:two_pair, :pair, :high_card, :nothing])
#   beats(:two_pair, [:pair, :high_card, :nothing])
#   beats(:pair, [:high_card, :nothing])
#   beats(:high_card, [:nothing])
#   describe "two_pair" do
#     it "musnt be a full house" do
#       value(hands[:two_pair].is_full_house).must_equal false
#     end
#   end
# end
