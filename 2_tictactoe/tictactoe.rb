class Board
  def initialize(rows, columns)
    if rows != 3 || columns != 3
      p 'ERROR: GO WITH 3x3 FOR NOW'
    else
      @x_is_legal = true 
      @o_is_legal = true
      @rows = rows
      @columns = columns
      @board = Hash.new(0)
      i = 1
      rows.times do
        array = ((((columns * rows) / rows * i) - columns + 1)..(columns * rows) / rows * i).to_a
        array = array.map do | number |
          number.to_s
        end
        @board[i] = array
        i += 1
      end
    @board
    display()
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
      else
        p "ERROR: ILLEGAL SYMBOL"
      end
    else
      p "ERROR: ILLEGAL NUMBER"
    end
    display()
  end

  private 
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



threeBoard = Board.new(3, 3)

bob = Player.new(threeBoard, "X")
mag = Player.new(threeBoard, "O")

bob.play(10)