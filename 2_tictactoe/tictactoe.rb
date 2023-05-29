class Board
  def initialize(size)
    if size != 3
      p 'ERROR: GO WITH 3x3 FOR NOW'
    else
      @rows = size
      @columns = size
      @maxturns = size ** 2
      generate_game
    end
  end

  def display
    p "-------------"
    i = 1
    @rows.times do
      p @board[i]
      i += 1
    end
    p "-------------"
  end

  def change_board(number, symbol)
    if legal_number?(number)
      get_coordinates(number, symbol)
      if legal_symbol?(symbol)
        process_turn(symbol)
        set_legality(symbol)
        @turn += 1
      else
        p "ERROR: ILLEGAL SYMBOL"
      end
    else
      p "ERROR: ILLEGAL NUMBER"
    end
    display
    get_winner
    if gameover?
      p "GAME OVER"
      generate_game
    end
  end

  private

  def generate_game    
    @turn = 1
    @board = Hash.new(0)
    generate_board
    allow_first_turn
    display
  end
  
  def generate_board
    i = 1
    @rows.times do
      array = ((((@columns * @rows) / @rows * i) - @columns + 1)..(@columns * @rows) / @rows * i).to_a
      array = array.map do | number |
        number.to_s
      end
      @board[i] = array
      i += 1
    end
  end

  def allow_first_turn
    @x_is_legal = true 
    @o_is_legal = true
  end

  def get_coordinates(number, symbol)
    @row = (number / @columns)
    if number % @columns != 0
      @row += 1
    end
    @column = ((@columns * ((number.to_f / @columns) - (@row - 1))) - 1).round(0)
  end

  def process_turn(symbol)
    @board[@row][@column] = symbol
  end


  def legal_symbol?(symbol)
    if @board[@row][@column] == "X" || @board[@row][@column] == "O"
      false
    elsif symbol == "X" && @x_is_legal == true
      true
    elsif symbol == "O" && @o_is_legal == true
      true
    else
      false
    end
  end

  def legal_number?(number)
    if (1..(@columns * @rows)).to_a.include?(number) == true 
      true
    else
      false
    end
  end

  def set_legality(symbol)
    if symbol == "X"
      @x_is_legal = false
      @o_is_legal = true 
    elsif symbol == "O"
      @x_is_legal = true
      @o_is_legal = false 
    end
  end

  def get_winner
    @x_wins = false
    @o_wins = false
    check_horizontal
    check_diagonal(true)
    check_diagonal(false)
    check_vertical
    if @x_wins == true
      p "X won"
    elsif @o_wins == true
      p "O won"
    end
  end

  def check_horizontal
    i = 1
    @rows.times do 
      if @board[i] == ["X", "X", "X"]
        @x_wins = true
        break
      elsif @board[i] == ["O", "O", "O"]
        @o_wins = true
        break
      else
        i += 1
      end
    end
  end

  def check_diagonal(from_left)
    i = 1
    @horizontal_array = Array.new(0)
    @columns.times do
      if from_left == true
        @horizontal_array << @board[i][(i - 1)]
      elsif from_left == false
        @horizontal_array << @board[i][(@columns - i)]
      end
      i += 1
    end
    if @horizontal_array == ["X", "X", "X"] 
      @x_wins = true
    elsif @horizontal_array == ["O", "O", "O"]
      @o_wins = true
    end
  end

  def check_vertical
    c = 0
    @columns.times do
      r = 1
      @vertical_array = Array.new(0)
      @rows.times do
        @vertical_array << @board[r][c]
        r += 1
      end
      if @vertical_array == ["X", "X", "X"] 
        @x_wins = true
      elsif @vertical_array == ["O", "O", "O"]
        @o_wins = true
      end
      c += 1
    end
  end

  def gameover?
    if @x_wins == true || @o_wins == true || @turn >= @maxturns
      true
    else
      false
    end
  end
end


class Player

  def initialize(board_name, symbol)
    if symbol != "X" && symbol != "O"
      p "ERROR: WRONG SYMBOL"
    else  
      @board_name = board_name
      @symbol = symbol
    end
  end

  def play(number)
    @board_name.change_board(number, @symbol)
  end
end

def choose_size
  board_size = gets.chomp.to_i
  if board_size != 5 && board_size != 3
    puts "(NOT) WRONG! (BUT) COME AGAIN (3 or 5)"
    choose_size
  end
  board_size
end

def choose_symbols
  first_symbol = gets.chomp.to_s
  p first_symbol
  if first_symbol == "X"
    second_symbol = "O"
  elsif first_symbol == "O" || first_symbol == "0"
    first_symbol = "O"
    second_symbol = "X"
    puts "Second Player, you are #{second_symbol}"
  else 
    puts "WRONG! COME AGAIN. X or O"
    start_game
  end
end


puts "Choose your board size"
board_size = choose_size

puts "First Player - your symbol: X or O?"

first_symbol = ""
second_symbol = ""
choose_symbols

p board_size 
board = Board.new(board_size)

p first_symbol
p second_symbol
first_player = Player.new(board, first_symbol)
second_player = Player.new(board, second_symbol)
