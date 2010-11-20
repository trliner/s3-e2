describe Pressman::Board do

  before do
    @board = Pressman::Board.new(:black, :white)
  end

  it "has eight rows" do
    Pressman::BOARD_SIZE.should == 8
    @board.grid.count.should == 8
  end

  it "has eight columns" do
    Pressman::BOARD_SIZE.should == 8
    @board.grid[0].count.should == 8
  end

end

describe Pressman::Board, "when first created" do

  before do
    @board = Pressman::Board.new(:black, :white)
  end

  it "has sixteen black stones" do
    @board.stones[:black].should == 16
  end

  it "has sixteen white stones" do
    @board.stones[:white].should == 16
  end

  it "has its top two rows filled with white stones" do
    Pressman::TOP_ROWS.each do |row|
      @board.grid[row].each {|stone| stone.color.should == :white}
    end
  end

  it "has its bottom two rows filled with black stones" do
    Pressman::BOTTOM_ROWS.each do |row|
      @board.grid[row].each {|stone| stone.color.should == :black}
    end
  end

end

describe Pressman::Board, "when validating moves" do

  before do
    @board = Pressman::Board.new(:black, :white)
    @black = Pressman::Player.new(:black)
    @white = Pressman::Player.new(:white)
  end

  it "doesn't allow players to pick up stone of another color" do
    @board.valid_stone?(@black, [0, 0]).should == false
    @board.valid_stone?(@white, [7, 7]).should == false
    @board.valid_stone?(@black, [3, 3]).should == false
    @board.valid_stone?(@white, [3, 3]).should == false
  end

  it "doesn't allow players to pick up a stone with no possible moves" do
    @board.valid_stone?(@black, [7,7]).should == false
    @board.valid_stone?(@white, [0,0]).should == false
    @board.valid_stone?(@white, [1, 0]).should == true
    @board.valid_stone?(@black, [6, 7]).should == true
  end

  it "allows players to move up and down" do
    @board.valid_dest?(@black, [6,7], [3,7]).should == true
    @board.valid_dest?(@white, [1,7], [4,7]).should == true
  end

  it "allows players to move left and right" do
    @board.valid_dest?(@black, [5,7], [5,1]).should == true
    @board.valid_dest?(@white, [3,1], [3,7]).should == true
  end

  it "allows players to move diagonally" do
    @board.valid_dest?(@black, [6,0], [4,2]).should == true
    @board.valid_dest?(@white, [1,0], [4,3]).should == true
    @board.valid_dest?(@black, [6,7], [4,5]).should == true
    @board.valid_dest?(@white, [1,7], [4,4]).should == true
  end



end