# frozen_string_literal: true

require 'matrix'
require 'pry'
require './lib/node.rb'

# represents the game board
class Grid
  attr_accessor :board, :display

  def initialize
    build_grid
  end

  def build_grid
    row = 0
    column = -1
    @board = Array.new(8) do
      Array.new(7) do
        column == 6 ? (row += 1; column = 0) : column += 1
        if row.zero?
          Node.new(column)
        elsif row == 7
          Node.new('end')
        else
          Node.new
        end
      end
    end
  end
end

