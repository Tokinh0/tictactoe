require './board.rb'
require './ai.rb'

class Game
  def initialize(difficulty: 'unbeatable', board: Board.new)
    @board = board
    @difficulty = difficulty 
  end

  def start_human_vs_human_game
    default_start('HxH')
  end

  def start_computer_vs_computer_game
    default_start('CxC')
  end

  def start_human_vs_computer_game
    default_start('HxC')
  end

  private 

  def default_start(game_type)
    @board.print_spots

    until @board.game_is_over?
      move = game_type == 'CxC' ? Ai.new(@board, @difficulty).get_best_move : nil
      @board.take_turn(move)
      if !@board.game_is_over?
        move = (game_type == 'CxC' || game_type == 'HxC') ? Ai.new(@board, @difficulty).get_best_move : nil
        @board.take_turn(move)
      end
    end

    puts "\nWinner is: #{@board.winner}\n" if @board.game_is_won?
    puts "\nIt's a draw !\n" if @board.game_is_tied?
  end
end
