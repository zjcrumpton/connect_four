require './lib/node.rb'
describe Node do
  describe "#initialize" do
    it "adds a nil value to objects by default" do
      node = Node.new
      expect(node.contains).to eql(nil)
    end

    it "takes an argument for containing non-default contains data" do
      node = Node.new("R")
      expect(node.contains).to eql("R")
    end

    it "has a next property pointing to nil by default" do
      node = Node.new
      expect(node.next).to eql(nil)
    end

    it "takes an argument for pointing next at something" do
      node = Node.new
      node.next = Node.new("Y")
      expect(node.next.contains).to eql("Y")
    end

    it "acts as a linked list" do
      node = Node.new
      node.next = Node.new("Y", Node.new("end"))
      expect(node.next.next.contains).to eql("end")
    end
  end
end
