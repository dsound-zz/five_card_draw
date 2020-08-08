require "pry"

SUITS = [:spades, :diamonds, :hearts, :clubs]
VALUES = (1..13).to_a
FACES = ["Jack", "Queen", "King", "Ace"]


class Card
    attr_accessor :suit, :value
    
    def initialize(*suit, value) 
        self.suit = suit
        self.value = value
    end
end

class Deck
    attr_reader :cards

    def initialize
        cards = VALUES.flat_map do |value| 
            SUITS.map do |suit| 
                Card.new(suit, value)
            end
        end
        @cards = cards
    end

    def shuffle
        self.cards.map(&:value).shuffle
    end

end

class Hand 
    attr_reader :hand    

    def initialize 
      @hand = Deck.new.cards.sample(5)
    end
end

class Game 

    def initialize 
        @hand1 = Hand.new.hand.map { |h| h.suit.push(h.value) } 
        @hand2 = Hand.new.hand.map { |h| h.suit.push(h.value) }  
    end 

    def play 
        hand1 = score(@hand1)
        hand2 = score(@hand2)
        # High card 
        if hand1[0] == hand2[0] 
            if hand1[1] > hand2[1] 
                puts "#{@hand1} beats #{@hand2}"
            else 
                puts "#{@hand2} beats #{@hand1}"
            end 
            return
        end
        # Other hands
        if hand1[0] > hand2[0] 
            puts "#{@hand1} beats #{@hand2}"
        else 
            puts "#{@hand2} beats #{@hand1}"
        end
        
    end


    private

    def score(hand)
        suit_count = {
            :spades => 0,
            :clubs => 0,
            :hearts => 0,
            :diamonds => 0
        }

        value_count = {
            1 => 0,
            2 => 0,
            3 => 0,
            4 => 0,
            5 => 0,
            6 => 0, 
            7 => 0, 
            8 => 0, 
            9 => 0,
            10 => 0, 
            11 => 0,
            12 => 0,
            13 => 0
        }

        # hand = Hand.new 

        # hand = hand.hand.map { |h| h.suit.push(h.value) }
    

        hand.each do |h| 
            suit_count[h[0]] += 1
            value_count[h[1]] += 1
        end

        final_hand_score = 0
        pair = 0
        three_of_kind = 0
        high_card = 0
        straight_check = []


        value_count.each do |k,v| 
            if v > 0 
            high_card = k
            current = high_card 
            if k > current  
                    high_card = k
            else   
                    high_card = current 
            end 
            straight_check.push(k)
            end
            
            if v == 2 
                pair += 1 
            end

            if v == 3 
                three_of_kind = 1
            end

            if pair == 1 # pair
                final_hand_score = 2
            elsif pair == 2 # two pair
                final_hand_score = 3 
            elsif three_of_kind == 1 # three of a kind
                final_hand_score = 4
            elsif straight(straight_check) # straight
                if straight(straight_check) && royal_flush_check(straight_check)  
                    final_hand_score = 9 # royal flush 
                elsif flush(suit_count) 
                    final_hand_score = 8 # straight flush
                else    
                    final_hand_score = 5  # straight  
                end
            elsif flush(suit_count) # flush
                    final_hand_score = 6 # flush
            else     
                final_hand_score = 1     
            end
        end
        if pair == 1 && three_of_kind == 1
            final_hand_score = 7 # full house
        end
        [final_hand_score, high_card]
    end

    # method for straight
    def straight(ary)  
        count = 0 
        card = ary[0]
        ary.each do |s| 
            if s - card == 1
                card = s 
                count += 1
            end    
        end
        if count == 4 
            return true
        else 
            return false
        end
    end

    # method for flush
    def flush(suits) 
        suits.each do |k, v| 
            if suits[k] == 5 
                return true 
            else   
                return false  
            end
        end 
    end

    # method for roayl_flush
    def royal_flush_check(ary)
        if ary == (9..13).to_a 
            return true 
        else 
            return false 
        end 
    end
end










