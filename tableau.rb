require_relative 'deck'


class Tableau
  attr_accessor :rows
  attr_reader :deck
  def initialize
    @rows = Array.new(8){[]}
    @deck = Deck.new
    populate(@deck)
  end

  def populate(deck)
    i = 0
    until deck.empty?
      i = 0 if i > 7
      @rows[i] << deck.remove_card
      i += 1
    end
  end

  def [](i)
    rows[i]
  end
end

class FreeCells < Tableau
  def initialize
    @rows = Array.new(4) {[]}
  end
end
