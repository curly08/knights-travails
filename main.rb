# frozen_string_literal: true

# Board class
class Board
  attr_accessor :knight, :squares
  attr_reader :rows, :columns

  def initialize
    @columns = [0, 1, 2, 3, 4, 5, 6, 7]
    @rows = [7, 6, 5, 4, 3, 2, 1, 0]
    @knight = Knight.new
    @grid = make_grid
    @squares = make_squares
  end

  def make_grid
    puts ' _ _ _ _ _ _ _ _ '
    rows.each do |y|
      print '|'
      columns.each do |x|
        print knight.position == [x, y] ? 'K|' : '_|'
      end
      puts "\n"
    end
  end

  def make_squares
    squares = []
    rows.each do |y|
      columns.each do |x|
        squares.push(Square.new(x, y))
      end
    end
    squares
  end
end

# Square class
class Square
  def initialize(x, y)
    @x = x
    @y = y
  end
end

# Knight class
class Knight
  attr_accessor :position, :possible_moves

  def initialize
    @position = [0, 0]
    @possible_moves = check_possible_moves
  end

  def check_possible_moves(position = @position)
    moves = [
      [(position[0] + 1), (position[1] + 2)],
      [(position[0] + 2), (position[1] + 1)],
      [(position[0] + 2), (position[1] - 1)],
      [(position[0] + 1), (position[1] - 2)],
      [(position[0] - 1), (position[1] - 2)],
      [(position[0] - 2), (position[1] - 1)],
      [(position[0] - 2), (position[1] + 1)],
      [(position[0] - 1), (position[1] + 2)]
    ]
    possible_moves = []
    moves.each do |move|
      possible_moves.push(move) if square_coordinates.include?(move)
    end
    possible_moves
  end

  def square_coordinates
    columns = [0, 1, 2, 3, 4, 5, 6, 7]
    rows = [7, 6, 5, 4, 3, 2, 1, 0]
    squares = []
    rows.each do |y|
      columns.each do |x|
        squares.push([x, y])
      end
    end
    squares
  end
end

board = Board.new
p board.knight.possible_moves
