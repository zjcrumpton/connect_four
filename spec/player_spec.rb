require './lib/player.rb'

describe Player do
  describe "#initialize" do
    it "runs get_name" do
      player = Player.new
      expect(player).to have_received(get_name)
    end

    it "runs display_info" do
      player = Player.new
      expect(player).to have_received(display_info)
    end

    it "takes an argument for player color" do
      player = Player.new("R")
      expect(player.color).to eql("R")
    end
  end

  describe "#get_info" do
    it "prompts the user for their name" do
    player = Player.new
    expect(player.name.nil?).to eql(false)
    end

    it "stores the user's checker color" do
      player = Player.new
      expect(player.color).to eql("R")
    end

    it "changes color to yellow for the second player" do
      player1 = Player.new
      player2 = Player.new
      expect(player2.color).to eql("Y")
    end
  end

  describe "#display_info" do
    it "returns player color" do
      player = Player.new
      expect(player.display_info).to eql("R")
    end

    describe "#drop_checker" do
      it "returns the object the checker fell into" do
        grid = Grid.new
        player = Player.new
        expect(player.drop_checker(1)).to eql([0, 7])
      end
    end
  end
end
