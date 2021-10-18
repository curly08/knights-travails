# frozen_string_literal: true

require 'pry-byebug'

# Board class
class Board
  attr_accessor :knight, :squares, :possible_moves, :possible_squares, :graph
  attr_reader :rows, :columns

  def initialize
    @columns = [0, 1, 2, 3, 4, 5, 6, 7]
    @rows = [7, 6, 5, 4, 3, 2, 1, 0]
    @knight = Knight.new
    @grid = make_grid
    @possible_squares = make_possible_squares
    @graph = graph_knight_moves
    # @possible_moves = check_possible_moves
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

  def graph_knight_moves
    graph = Graph.new
    possible_squares.each { |square_coordinates| graph.add_node(Node.new(square_coordinates)) }
    graph.nodes.each do |coordinates, _node|
      neighbors = check_possible_moves(coordinates)
      neighbors.each do |neighbor|
        graph.add_edge(coordinates, neighbor) if check_if_neighbor_exists(graph, coordinates, neighbor).nil?
      end
    end
    graph
  end

  def check_if_neighbor_exists(graph, origin, neighbor)
    return nil if graph.nodes[origin].neighbors.empty?

    graph.nodes[origin].neighbors.find { |node| node.coordinates == neighbor }
  end
end

# Square class
class Node
  attr_reader :coordinates, :neighbors

  def initialize(coordinates)
    @coordinates = coordinates
    @neighbors = []
  end

  def add_edge(neighbor)
    @neighbors << neighbor
  end
end

# Graph class
class Graph
  attr_reader :nodes

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

  def initialize(position = [0, 0])
    @position = position
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
# binding.pry
board.graph
