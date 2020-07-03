require './lib/grid.rb'

describe Grid do
  describe "#initialize" do
    it "runs build_grid method" do
      grid = Grid.new
      expect(grid).to have_received(build_grid)
    end
  end

  describe "#build_grid" do
    it "creates a matrix" do
      grid = Grid.new
      expect(grid.board.class).to eql(Matrix)
    end

    it "populates top row with nodes containing numbers 1-7" do
      grid = Grid.new
      expect(grid.board[0, 1].contains).to eql(2)
  end

  it "populates middle rows with empty nodes" do
    grid = Grid.new
    expect(grid.board[4, 4],contains).to eql(nil)
  end

  it "populates bottom row with nodes containing string: 'end'" do
    grid = Grid.new
    expect(grid.board[3, 7]).to eql("end")
  end

  describe "#add_links" do
    it "returns a node above the end row" do
      grid = Grid.new
      expect(grid.add_links.next.contains).to eql("end")
    end

    it "creates a linked list type structure" do
      grid = Grid.new
      grid.add_links
      expect(grid.board[0, 0].next).not_to eql(nil)
    end

    it "acts on the entire top row of the board" do
      grid = Grid.new
      grid.add_links
      expect(grid.board[0, 7].next).not_to eql(nil)
    end
end
