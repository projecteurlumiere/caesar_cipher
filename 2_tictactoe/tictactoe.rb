class Board
  def initialize(rows, columns)
    if rows != 3 || columns != 3
      p "ERROR: GO WITH 3x3 FOR NOW"
    else
      @rows = rows
      @columns = columns
      @board = Hash.new(0)
      i = 1
      i_d = rows
      rows.times do
        array = ((((columns * rows) / rows * i) - columns + 1)..(columns * rows) / rows * i).to_a
        @board[i] = array.to_a
        i += 1
        i_d -= 1
      end
    @board
    end
  end

  def change_board(number, symbol)
    row = (number / @columns)
    if number % @columns != 0
      row += 1
    end
    p row
    column = ((@columns * ((number.to_f / @columns) - (row - 1))) - 1).round(0)
    @board[row][column] = symbol
  end

  def display
    i = 1
    @rows.times do
      p @board[i]
      i += 1
    end
  end
end

module Playable
  def play(number)
    @board_name.change_board(number, @symbol)
  end
end


class PlayerOne
  include Playable

  def initialize(board_name)
    @board_name = board_name
    @symbol = "X"
  end
end

class PlayerTwo
  include Playable
  
  def initialize(name, board_name)
    @name = name
    @name = board_name
    @symbol = "O"
  end
end


threeBoard = Board.new(3, 3)
threeBoard.display

bob = PlayerOne.new(threeBoard)
i = 1

9.times do
  bob.play(i)
  i += 1
end

threeBoard.display
