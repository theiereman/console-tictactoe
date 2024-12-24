class Game
  def init
    @current_turn = 1
    @is_finished = false
    @board = Array.new(3) { Array.new(3,0) }
    loop
  end

  def loop
    draw_board
    winner = has_winner?
    if winner > 0
      puts "Player #{winner} has won!"
      return
    end

    unless empty_square?
      puts "Its a draw!"
      return
    end

    puts "Player #{@current_turn} turn."
    user_input = get_user_input
    until is_input_valid(*user_input)
      draw_board
      puts "Input invalid! Please try again."
      user_input = get_user_input
    end

    @board[user_input[0]][user_input[1]] = @current_turn

    next_players_turn

    loop
  end

  private def next_players_turn
    @current_turn = @current_turn == 1 ? 2 : 1
  end

  private def get_user_input()
    puts "Column index ?"
    col_index = gets.chomp.to_i
    puts "Row index ?"
    row_index = gets.chomp.to_i
    [row_index,col_index]
  end

  private def is_input_valid(col_index,row_index)
    @board[col_index][row_index] == 0
  end

  private def draw_board
    @board.each do |col|
      p col
    end
  end

  private def empty_square?
    @board.each { |column| column.any?(0) }
  end

  private def has_winner?
    @board.each_with_index do |column, i|
      #colonnes
      if column[0] != 0 && (column[0] == column[1] && column[1] == column[2])
        return column[0]
      end

      #lignes
      if @board[0][i] != 0 && (@board[0][i] == @board[1][i] && @board[1][i] == @board[2][i])
        return @board[0][i]
      end
    end

    #diagonales
    if @board[0][0] != 0 && (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2])
      return @board[0][0]
    end

    if @board[0][2] != 0 && @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]
      return @board[0][2]
    end

    0
  end
end