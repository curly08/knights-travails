# frozen_string_literal: true

require 'pry-byebug'

# Board class
class Board
  attr_accessor :knight, :squares, :possible_moves, :possible_squares
  attr_reader :rows, :columns

  def initialize
    @columns = [0, 1, 2, 3, 4, 5, 6, 7]
    @rows = [7, 6, 5, 4, 3, 2, 1, 0]
    @knight = Knight.new
    @grid = make_grid
    @possible_squares = make_possible_squares
    # @possible_moves = check_possible_moves
    # binding.pry
    # @squares = make_squares
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

  def make_graph(start)
    graph = []
    graph.push(Square.new(start, check_possible_moves(start)))
    graph
  end

  def make_possible_squares
    squares = []
    rows.each do |x|
      columns.each do |y|
        squares.push([x, y])
      end
    end
    squares
  end

  def check_possible_moves(position)
    knight.moves(position).select { |move| possible_squares.include?(move) }
  end

  # def knight_moves(start, end)
    
  # end
end

# Square class
class Node
  attr_reader :coordinates

  def initialize(coordinates)
    @coordinates = coordinates
    @adjacent_nodes = []
  end

  def add_edge(adjacent_node)
    @adjacent_nodes << adjacent_node
  end
end

# Graph class
class Graph
  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.coordinates] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end
end

# Knight class
class Knight
  attr_accessor :position

  def initialize
    @position = [0, 0]
  end

  def moves(position)
    [
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
# p board.check_possible_moves([3,0])
p board.make_graph([0,0])