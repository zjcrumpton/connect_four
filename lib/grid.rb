# frozen_string_literal: true

require 'matrix'
require 'pry'
require './lib/node.rb'

class Grid
  attr_accessor :board, :display

  def initialize
    build_grid
  end

  def build_grid
    i = 1
    j = 0
    @board = Array.new(8) do
      Array.new(7) do |item|
        # if we're operating on the top row
        if i <= 7 && j == 0
          node = Node.new(i)
          if i == 7
            j += 1
            i = 0
          else
            i += 1
          end
        # if we're operating on a middle row
        elsif i <= 7 && j < 6
          node = Node.new(nil)
          if i ==7
            j += 1
            i = 0
          else
            i += 1
          end
        # if we're operating on the bottom row
        else
          node = Node.new("end")
        end
        node
      end
      # j += 1
      # i = 0
    end
  end
end

