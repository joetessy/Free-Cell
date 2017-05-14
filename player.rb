class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def prompt
    puts ""

    puts "                  CONTROLS"
    puts ""
    puts "TAB(1-8) for moving a tableau card"
    puts "FREE(1-4) for moving a free cell card"
    puts "FOUND for moving to a foundation card"
    puts ""

    gets.chomp.upcase
  end
end
