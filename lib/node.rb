# frozen_string_literal: true

require 'pry'

# represents a single space on the Connect 4 Grid
class Node
  attr_accessor :contains, :next_node
  def initialize(contains = nil, next_node = nil)
    @contains = contains
    @next_node = next_node
  end
end
