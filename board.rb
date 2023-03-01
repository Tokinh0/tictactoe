class Board
  ACCEPTED_VALUES = ('0'..'8').to_a
  COMPUTER_MARK = "O"
  HUMAN_MARK = "X"

  attr_accessor :spots, :current_player
  
  def initialize(current_player = HUMAN_MARK)
    @spots = ACCEPTED_VALUES.dup
    @current_player = current_player
  end

  def write(spot, mark)
    @spots[spot.to_i] = mark.to_s if valid_entry?(spot)
    
    nil
  end

  def valid_entry?(value)
    return true if ACCEPTED_VALUES.include?(value.to_s) &&
    @spots[value.to_i] != COMPUTER_MARK && @spots[value.to_i] != HUMAN_MARK

    puts "invalid entry: #{value}\n" 
    false
  end

  def print_spots
    puts "\n"
    puts " #{@spots[0]} | #{@spots[1]} | #{@spots[2]} \n===+===+===\n #{@spots[3]} | #{@spots[4]} | #{@spots[5]} \n===+===+===\n #{@spots[6]} | #{@spots[7]} | #{@spots[8]} \n"
    puts "\n"
  end

  def available_spaces
    available = []
    @spots.each do |s|
      if s != "X" && s != "O"
        available <<  s
      end
    end
    available
  end

  def game_is_over?
    game_is_won? || game_is_tied?
  end

  def game_is_won?
    !winner.nil?
  end

  def winner
    return [@spots[0], @spots[1], @spots[2]].uniq.first if [@spots[0], @spots[1], @spots[2]].uniq.length == 1
    return [@spots[3], @spots[4], @spots[5]].uniq.first if [@spots[3], @spots[4], @spots[5]].uniq.length == 1
    return [@spots[6], @spots[7], @spots[8]].uniq.first if [@spots[6], @spots[7], @spots[8]].uniq.length == 1
    return [@spots[0], @spots[3], @spots[6]].uniq.first if [@spots[0], @spots[3], @spots[6]].uniq.length == 1
    return [@spots[1], @spots[4], @spots[7]].uniq.first if [@spots[1], @spots[4], @spots[7]].uniq.length == 1
    return [@spots[2], @spots[5], @spots[8]].uniq.first if [@spots[2], @spots[5], @spots[8]].uniq.length == 1
    return [@spots[0], @spots[4], @spots[8]].uniq.first if [@spots[0], @spots[4], @spots[8]].uniq.length == 1
    return [@spots[2], @spots[4], @spots[6]].uniq.first if [@spots[2], @spots[4], @spots[6]].uniq.length == 1
    nil
  end

  def game_is_tied?
    @spots.all? { |s| s == COMPUTER_MARK || s == HUMAN_MARK }
  end

  def reset(index, value)
    @spots[index.to_i] = value.to_s

    nil
  end

  def duplicate
    new_board = dup
    new_board.spots = @spots.dup
    new_board.current_player = @current_player
    new_board
  end

  def take_turn(spot = nil)
    puts "Player #{@current_player} turn:"
    spot = gets.chomp.to_i if spot.nil?
    write(spot, @current_player)
    switch_player
    print_spots
    sleep 0.3
  end

  def switch_player
    @current_player = @current_player == HUMAN_MARK ? COMPUTER_MARK : HUMAN_MARK
  end
end