# frozen_string_literal: true

require 'pry'
require './lib/grid'
require 'colorize'
class Player
  attr_accessor :name, :color, :last_dropped

  def initialize(color)
    @color = color
    @name = get_name
    puts display_info
  end

  def get_name
    print "Enter #{@color} Player Name: ".green
    gets.chomp
  end

  def display_info
    "Hi #{@name}, your checker color is #{@color}!\n\n"
  end

  def drop_checker(node)
    until !node.next_node.contains.nil? do 
      node = node.next_node
    end
    node.contains = @color
    @last_dropped = node
  end
end
