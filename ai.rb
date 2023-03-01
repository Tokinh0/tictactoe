class Ai 
  def initialize(board, difficulty)
    @board = board
    @difficulty = difficulty
  end

  def get_best_move
    return center_or_corner(@board) if first_move?
    return best_move(@board, @board.current_player)[:best_move] if unbeatable? || hard?
    return random_spot(@board)
  end

  private 

  def best_move(board, current_player)
    return { score: eval_score(board, @board.current_player), best_move: nil } if board.game_is_over?
    
    scores = []
        
    board.available_spaces.each do |as|
      board_dup = board.duplicate
      board_dup.reset(as, current_player)
      board_dup.switch_player
      score = best_move(board_dup, board_dup.current_player)[:score]      
      scores << { score: score, best_move: as }
    end
         
    board.current_player == @board.current_player ? scores.max_by { |s| s[:score] } : scores.min_by { |s| s[:score] }
  end

  def eval_score(board, player)    
    return 0 if !board.game_is_won?
    return 1 if board.winner == player
    -1
  end

  def random_spot(board)
    @board.available_spaces.sample
  end

  def center_or_corner(board)
    (board.available_spaces & ['4', '0', '2', '6', '8']).sample
  end

  def first_move?
    @board.available_spaces.length >= 9
  end

  def easy?
   @difficulty.to_s == 'easy'
  end

  def hard?
    @difficulty.to_s == 'hard' && rand < 0.70
  end

  def unbeatable?
    @difficulty.to_s == 'unbeatable'
  end
end