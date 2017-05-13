require_relative 'card'

class Deck

  def self.create_deck
    Card.suits.product(Card.values).map {|i,j| Card.new(i,j) }.shuffle
  end

  attr_reader :cards
  def initialize(cards = Deck.create_deck)
    @cards = cards
  end

  def remove_card
    @cards.pop
  end

  def empty?
    @cards.empty?
  end


end
