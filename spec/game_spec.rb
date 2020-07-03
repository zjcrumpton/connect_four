require './lib/game.rb'

describe Game do
  describe "#initialize" do
    it "creates 2 players" do
      game = Game.new
      expect(game).to have_received(Player.new).twice
    end

    it "holds a current player value" do
      game = Game.new
      expect(game.current_player.name).to eql(player1.name)
    end

    it "creates a new grid" do
      game = Game.new
      expect(game).to have_received(Grid.new).once
    end

    it "holds a current color value" do
      game = Game.new
      expect(game.current_color).to eql("R")
    end

    it "holds the current state of the board" do
      game = Game.new
      expect(game.board.nil?).to eql(false)
    end
  end

  describe "#switch_player" do
    it "alternates between players" do
      game = Game.new
      game.switch_players
      expect(game.current_player.name).to eql(player2.name)
    end

    it "alternates between colors" do
      game = Game.new
      game.switch_players
      expect(game.current_color).to eql("Y")
    end
  end

  describe "#prompt_player" do
    it "returns the node that player selected" do
      game = Game.new
      expect(game.prompt_player(1).contains).to eql(1)
    end

    it "prompts again if given an invalid response" do
      game = Game.new
      game.prompt_player("z")
      expect(game).to have_received(prompt_player)
    end

    it "switches color after a valid input" do
      game = Game.new
      game.prompt_player(1)
      expect(game).to have_received(switch_player)
    end

    it "passes a valid value to drop_checker" do
      game = Game.new
      game.prompt_player(1)
      expect(game).to have_received(drop_checker)
    end
  end

  describe "#check_win" do
    it "checks the rows" do
      game = Game.new
      game.check_win
      expect(game).to have_received(check_row)
    end

    it "checks the columns" do
      game = Game.new
      game.check_win
      expect(game).to have_received(check_columns)
    end

    it "checks the diagonals" do
      game = Game.new
      game.check_win
      expect(game).to have_received(check_diags)
    end
  end

  describe "#check_row" do
    it "returns false if no win" do
      game = Game.new
      expect(game.check_row).to eql(false)
    end

    it "returns true if win condition is met" do
      game = Game.new
      current_player.drop_checker(1)
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(2)
      current_player.drop_checker(3)
      current_player.drop_checker(3)
      current_player.drop_checker(4)
      expect(game.check_row).to eql(true)
    end
  end

  describe "#check_column" do
    it "returns false if no win" do
      game = Game.new
      expect(game.check_column).to eql(false)
    end

    it "returns true if win condition is met" do
      game = Game.new
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(1)
      expect(game.check_column).to eql(true)
    end
  end
  describe "#check_diag" do
    it "returns false if no win" do
      game = Game.new
      expect(game.check_diag).to eql(false)
    end

    it "returns true if win condition is met" do
      game = Game.new
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(2)
      current_player.drop_checker(3)
      current_player.drop_checker(3)
      current_player.drop_checker(3)
      current_player.drop_checker(4)
      current_player.drop_checker(4)
      current_player.drop_checker(4)
      current_player.drop_checker(1)
      current_player.drop_checker(4)
      expect(game.check_diag).to eql(true)
    end
  end

  describe "#game_over" do
    it "returns false if no win condition is met" do
      game = Game.new
      expect(game.game_over).to eql(false)
    end

    it "returns true if win condition is met" do
      game = Game.new
      current_player.drop_checker(1)
      current_player.drop_checker(1)
      current_player.drop_checker(2)
      current_player.drop_checker(2)
      current_player.drop_checker(3)
      current_player.drop_checker(3)
      current_player.drop_checker(4)
      expect(game.game_over).to eql(true)
    end
  end

  describe "#take_turn" do
    it "displays the grid" do
      game = game.new
      game.take_turn
      expect(game.take_turn).to have_received(@grid.display_grid)
    end

    it "runs prompt_player" do
      game = Game.new
      game.take_turn
      expect(game.take_turn).to have_received(prompt_player)
    end

    it "runs again if game_over returns nil" do
      game = Game.new
      game.take_turn
      expect(game.take_turn).to have_received(take_turn)
    end
  end

  describe "#start" do
    it "runs take_turn if passed '1'" do
      game = Game.new
      expect(game.start(1)).to have_received(take_turn)
    end
  end
end
