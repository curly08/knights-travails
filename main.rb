# frozen_string_literal: true

# Board class
class Board
  attr_accessor :knight, :squares, :possible_moves
  attr_reader :rows, :columns

  def initialize
    @columns = [0, 1, 2, 3, 4, 5, 6, 7]
    @rows = [7, 6, 5, 4, 3, 2, 1, 0]
    @knight = Knight.new
    @grid = make_grid
    @squares = make_squares
    @possible_moves = check_possible_moves
  end

  def make_grid
    puts ' _ _ _ _ _ _ _ _ '
    rows.each do |x|
      print '|'
      columns.each do |y|
        print knight.position == [x, y] ? 'K|' : '_|'
      end
      puts "\n"
    end
  end

  def make_squares
    squares = []
    rows.each do |x|
      columns.each do |y|
        squares.push(Square.new([x, y]))
      end
    end
    squares
  end

  def check_possible_moves
    squares.select { |square| knight.moves.include?(square.coordinates) }
  end
end

# Square class
class Square
  attr_accessor :data
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    @data = '_'
  end
end

# Knight class
class Knight
  attr_accessor :position
  attr_reader :moves

  def initialize
    @position = [0, 0]
    @moves = [
      [(position[0] + 1), (position[1] + 2)],
      [(position[0] + 2), (position[1] + 1)],
      [(position[0] + 2), (position[1] - 1)],
      [(position[0] + 1), (position[1] - 2)],
      [(position[0] - 1), (position[1] - 2)],
      [(position[0] - 2), (position[1] - 1)],
      [(position[0] - 2), (position[1] + 1)],
      [(position[0] - 1), (position[1] + 2)]
    ]
  end
end

board = Board.new
p board.possible_moves
