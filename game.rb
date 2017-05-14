require 'byebug'
require_relative 'tableau'
require_relative 'player'



class Game
  attr_reader :tableau, :free_cells, :foundations, :player
  def initialize(player)
    @player = player
    @tableau = Tableau.new
    @free_cells = FreeCells.new
    @foundations = {:spade => [], :heart => [], :club => [], :diamond => []}
  end

  def tableau_move(start_row, end_row)
    if start_row.last.color != end_row.last.color && start_row.last.rank == end_row.last.rank - 1 || start_row.empty?
      end_row.push(start_row.pop)
    else
      raise 'Invalid move, card must be a different color and have one less value'
    end
  end

  def foundation_move(start_row)
    if @foundations[start_row.last.suit].empty?
      if start_row.last.rank == 1
        @foundations[start_row.last.suit].push(start_row.pop)
      else
        raise "Invalid move"
      end
    elsif start_row.last.rank == @foundations[start_row.last.suit].last.rank + 1
        @foundations[start_row.last.suit].push(start_row.pop)
    else
∑      raise "Invalid move"
    end
  end

  def to_free_cell(start_row)
    raise "No more free cells" if @free_cells.rows.none?{|x| x.empty?}
    @free_cells.rows.each do |row|
      if row.empty?
        row.push(start_row.pop)
        break
      end
    end
  end

  def display
    system('clear')
    puts "=============================================="
    puts "        HELLO #{@player.name.upcase}, WELCOME TO FREECELL"
    puts "=============================================="

    puts "Foundations              FreeCells"
    @foundations.each do |k,v|
      if !@foundations[k].empty?
        print "["+@foundations[k].last.to_s+"]"
      else
        print "[  ] "
      end
    end
    print "     "
    @free_cells.rows.each do |card|
      if card.empty?
        print "[  ] "
      else
        print "["+card.first.to_s+"]"
      end
    end

    puts ""
    puts ""
    puts ""
    i = 0
    while i < @tableau.rows.length
      @tableau.rows.each do |row|
        if row[i].nil?
          print "      "
        else
          print row[i].to_s + "   "
        end
      end
      i += 1
      print "\n"
    end
    puts ""
    puts ""
    puts ""
    nil
  end

  def take_turn
    begin
    system('clear')
    display
    puts "WHERE ARE YOU MOVING FROM"
    move_from = @player.prompt
    system('clear')
    display
    puts "WHERE ARE YOU MOVING TO"
    puts "IF YOU ARE MOVING TO A FOUNDATION OR FREE CELL, DON'T INCLUDE A NUMBER"
    move_to = @player.prompt
    puts ""
    handle_prompt(move_from, move_to)
    rescue
      puts ""
      sleep(2)
      retry
    end
    system('clear')
    display

  end

  def handle_prompt(move_from, move_to)
    if move_from[0...-1] == "TAB"
      if move_to[0...-1] == "TAB"
        puts "Moving from Tableau row #{move_from[-1]} to Tableau row #{move_to[-1]}"
        sleep(.5)
        tableau_move(@tableau[move_from[-1].to_i - 1], @tableau[move_to[-1].to_i - 1])
      elsif move_to[0..-1] == "FREE"
        puts "Moving from Tableau row #{move_from[-1]} to Free Cell"
        sleep(.5)
        to_free_cell(@tableau[move_from[-1].to_i - 1])
      elsif move_to[0..-1] == "FOUND"
        puts "Moving from Tableau row #{move_from[-1]} to Foundation"
        sleep(.5)
        foundation_move(@tableau[move_from[-1].to_i - 1])
      end
    elsif move_from[0...-1] == "FREE"
      if move_to[0...-1] == "TAB"
        puts "Moving from Free Cell ##{move_from[-1]} to Tableau row #{move_to[-1]}"
        sleep(.5)
        tableau_move(@free_cells[move_from[-1].to_i - 1], @tableau[move_to[-1].to_i - 1])
      elsif move_to[0..-1] == "FOUND"
        debugger
        puts "Moving from Free Cell##{move_from[-1]} to Foundation row #{move_to[-1]}"
        sleep(.5)
        foundation_move(@free_cells[move_from[-1].to_i - 1])
      end
    end
  end

  def run
    until @tableau.rows.all?{|row| row.empty?}
      take_turn
    end
    system('clear')
    display
    puts "FUCK OMG U WON" * 1000
  end

end

if __FILE__ == $PROGRAM_NAME
  system('clear')
  print "Enter your name please: "
  player = Player.new(gets.chomp)
  game = Game.new(player)
  game.run
end
