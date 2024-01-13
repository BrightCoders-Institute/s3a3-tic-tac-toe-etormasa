require 'matrix'

class Board
  def initialize(rows, cols)
    @dimension = Matrix.build(rows, cols) { ' ' }
  end

  def print_board
    @dimension.to_a.each_with_index do |row, index|
      puts row.join('|')
      puts '-----' unless index == @dimension.row_count - 1
    end
  end

  def make_move(row, col, symbol)
    if valid_move?(row, col)
      @dimension[row, col] = symbol
      true
    else
      false
    end
  end

  def valid_move?(row, col)
    row.between?(0, @dimension.row_count - 1) && col.between?(0, @dimension.column_count - 1) && @dimension[row, col] == ' '
  end

  def winner?(symbol)
    (0...@dimension.row_count).any? do |i|
      @dimension.row(i).count(symbol) == @dimension.row_count ||
        @dimension.column(i).count(symbol) == @dimension.column_count
    end ||
      @dimension.each(:diagonal).count(symbol) == @dimension.row_count ||
      @dimension.reverse_each(:diagonal).count(symbol) == @dimension.row_count
  end

  def draw?
    @dimension.to_a.flatten.none? { |cell| cell == ' ' }
  end
end
