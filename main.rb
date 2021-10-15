# frozen_string_literal: true

# Board class
class Board
  attr_accessor :squares, :knight

  def initialize
    @grid = make_grid
    @knight = Knight.new
  end

  def make_grid
    rows = [0, 1, 2, 3, 4, 5, 6, 7]
    columns = [7, 6, 5, 4, 3, 2, 1, 0]
    squares = []
    puts ' _ _ _ _ _ _ _ _ '
    columns.each do |y|
      print '|'
      rows.each do |x|
        squares.push(Square.new(x, y))
        print '_|'
      end
      puts "\n"
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
  attr_accessor :position, :squares

  def initialize
    @position = [0, 0]
    @squares = make_square_coordinates
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
      possible_moves.push(move) if squares.include?(move)
    end
    possible_moves
  end

  def make_square_coordinates
    rows = [0, 1, 2, 3, 4, 5, 6, 7]
    columns = [7, 6, 5, 4, 3, 2, 1, 0]
    squares = []
    columns.each do |y|
      rows.each do |x|
        squares.push([x, y])
      end
    end
    squares
  end
end

board = Board.new
p board.knight.check_possible_moves
