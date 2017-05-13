class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def prompt
    puts ""

    puts "GIVE ME A"
    puts "FREE  #(0-7) for moving a free cell card"
    puts "TAB   #(0-3) for moving a tableau card"
    puts "FOUND #(0-3) for moving a tableau card"
    puts ""

    gets.chomp
  end



end
