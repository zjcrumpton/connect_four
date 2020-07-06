# frozen_string_literal: true

require 'matrix'
require 'pry'
require './lib/node.rb'

# represents the game board
class Grid
  attr_accessor :board, :display

  def initialize
    build_grid
    add_links
  end

  def build_grid
    row = 0
    column = -1
    @board = Array.new(8) do
      Array.new(7) do
        column == 6 ? (row += 1; column = 0) : column += 1
        if row.zero?
          Node.new(column, [row, column])
        elsif row == 7
          Node.new('end', [row, column])
        else
          Node.new(nil, [row, column])
        end
      end
    end
  end

  def add_links
    @board[0].each do |head|
      current = head
      until current.contains == 'end'
        current.next_node = @board[current.location[0] + 1][current.location[1]]
        current = current.next_node
      end
    end
  end
end
