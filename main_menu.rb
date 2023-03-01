require './game.rb'

@difficulties = { 'easy': 0, 'hard': 1, 'unbeatable': 2 }

def draw_difficulty_menu 
  puts '== CHOOSE A DIFFICULTY LEVEL =='
  @difficulties.map{|x| puts "#{x[1]} - #{x[0]}"}
  print '>'
end

def draw_main_menu
  puts '===== CHOOSE A GAME MODE ====='
  puts '0 - Human vs Human            |'
  puts '1 - Human vs Computer         |'
  puts '2 - Computer vs Computer      |'
  puts '3 - exit                      |'
  print '>'
end

game_type = nil
level = nil
until game_type == 3
  draw_main_menu
  game_type = gets.chomp.to_i
  case game_type
  when 0
    Game.new.start_human_vs_human_game
  when 1
    draw_difficulty_menu
    until level
      level = gets.chomp.to_i
      if @difficulties.values.include?(level) 
        Game.new(difficulty: @difficulties.key(level)).start_human_vs_computer_game
      else
        puts 'insert a number corresponding to the level difficulty'
        level = nil
      end
    end
  when 2
    Game.new.start_computer_vs_computer_game
  when 3
    puts 'Thanks for playing! :)'
  else
    puts 'invalid game type'
  end
  level = nil
end



