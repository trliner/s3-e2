describe Board do

  before do
    @board = Board.new(:black, :white)
  end

  it "has eight rows" do
    Board::ELEMENT.count.should == 8
    @board.grid.count.should == 8
  end

  it "has eight columns" do
    Board::ELEMENT.count.should == 8
    @board.grid[0].count.should == 8
  end

end

describe Board, "when first created" do

  before do
    @board = Board.new(:black, :white)
  end

  it "has sixteen black stones" do
    @board.stones[:black].should == 16
  end

  it "has sixteen white stones" do
    @board.stones[:white].should == 16
  end

  it "has its top two rows filled with white stones" do
    Board::ELEMENT.each do |col|
      @board.top_rows.each do |row|
        @board.grid[row][col].should == :white
      end
    end
  end

  it "has its bottom two rows filled with black stones" do
    Board::ELEMENT.each do |col|
      @board.bottom_rows.each do |row|
        @board.grid[row][col].should == :black
      end
    end
  end

end

describe Board do

  it "doesn't allow players to pick up stone of another color" do
    @board = Board.new(:black, :white)
    @black = Player.new(:black)
    @white = Player.new(:white)
    @board.valid_stone?(@black, [0, 0]).should == false
    @board.valid_stone?(@white, [7, 7]).should == false
    @board.valid_stone?(@black, [3, 3]).should == false
    @board.valid_stone?(@white, [3, 3]).should == false
    @board.valid_stone?(@white, [0, 0]).should == true
    @board.valid_stone?(@black, [7, 7]).should == true
  end

end