require 'colorize'

class Card

  SUIT_IMAGES = {
    :club      => "♣",
    :diamond   => "♦",
    :heart     => "♥",
    :spade     => "♠"
  }

  SUITS = {
    :heart => :red,
    :diamond => :red,
    :spade => :black,
    :club => :black
  }
  VALUES =
  {
    :ace => 1,
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13
  }
  RENDER =
  {
    :ace => "A",
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => "J",
    :queen => "Q",
    :king => "K"
  }

  def self.suits
    SUITS.keys
  end

  def self.values
    VALUES.keys
  end

  attr_reader :suit, :value
  attr_accessor :type

  def initialize(suit, value)
    @suit = suit
    @value = value
    @type = :tableau
  end

  def rank
    VALUES[value]
  end

  def render_face
    RENDER[:value]
  end

  def color
    SUITS[suit]
  end

  def to_s
    if rank != 10
      "#{RENDER[value]} #{SUIT_IMAGES[suit]}".colorize(color)
    else
      "#{RENDER[value]}#{SUIT_IMAGES[suit]}".colorize(color)
    end
  end

end
