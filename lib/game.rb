# frozen_string_literal: true

require 'pry'
require './lib/grid.rb'
require './lib/player.rb'
require 'colorize'

# manages the state of the game and allows the classes to interact
class Game
  attr_accessor :current_player, :players, :grid, :turn_count
  def initialize
    puts '
    ZJCrumpton Presents:

     /$$$$$$                                                /$$           /$$   /$$
    /$$__  $$                                              | $$          | $$  | $$
   | $$  \__/ /$$$$$$ /$$$$$$$ /$$$$$$$  /$$$$$$  /$$$$$$$/$$$$$$        | $$  | $$
   | $$      /$$__  $| $$__  $| $$__  $$/$$__  $$/$$_____|_  $$_/        | $$$$$$$$
   | $$     | $$  \ $| $$  \ $| $$  \ $| $$$$$$$| $$       | $$          |_____  $$
   | $$    $| $$  | $| $$  | $| $$  | $| $$_____| $$       | $$ /$$            | $$
   |  $$$$$$|  $$$$$$| $$  | $| $$  | $|  $$$$$$|  $$$$$$$ |  $$$$/            | $$
    \______/ \______/|__/  |__|__/  |__/\_______/\_______/  \___/              |__/


                                                                                   '.light_blue
    start
  end

  def start
    @players = [Player.new('Red'), Player.new('Yellow')]
    @current_player = @players[0]
    @grid = Grid.new
    @grid.display_board
    @turn_count = 0
    take_turn
  end

  def take_turn
    @current_player.drop_checker(@grid.board[0][prompt_player])
    check_four(get_diag)
    @grid.display_board
    return game_over if check_win == true

    switch_player
    take_turn
  end

  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def prompt_player
    choices = %w[0 1 2 3 4 5 6]
    puts "#{@current_player.name} - Please select the column where you want to drop a checker: 0-6"
    choice = gets.chomp
    choices.include?(choice) ? (return choice.to_i) : prompt_player
  end

  def check_win
    return true if check_four(get_column) == true || check_four(get_row) == true || check_diags == true

    false
  end

  def check_row(winning_checkers = 0)
    @grid.board[current_player.last_dropped.location[0]].each do |node|
      node.contains == @current_player.color ? winning_checkers += 1 : winning_checkers = 0
      return true if winning_checkers == 4
    end
  end

  def get_row
    @grid.board[current_player.last_dropped.location[0]]
  end

  def get_column
    @grid.board.transpose[@current_player.last_dropped.location[1]]
  end

  def check_diags
    return true if check_four(get_diag) == true || check_four(get_diag(true)) == true

    false
  end

  def get_diag(reversed = false, diagonal = nil)
    padding = [*0..(@grid.board.length - 1)]
    padding = padding.reverse if reversed
    padding = padding.map { |i| [nil] * i }
    diag = padding.reverse.zip(@grid.board).zip(padding).map(&:flatten).transpose.map(&:compact).reject { |x| x.size < 5 }
    diag.each { |arr| arr.include?(@current_player.last_dropped) ? (diagonal = arr) : next }
    return diagonal
  end


  def check_four(array, winning_checkers = 0)
    return false if array.nil?
    array.each do |node|
      node.contains == @current_player.color ? winning_checkers += 1 : winning_checkers = 0
      return true if winning_checkers == 4
    end
  end

  def game_over
    puts "#{@current_player.name} is the winner!"
    true
  end
end

Game.new
