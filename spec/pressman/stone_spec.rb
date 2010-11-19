describe Stone do

  before do
    @black = Player.new(:black)
    @board = Board.new(:black, :white)
    @stone = @board.stone_at([6,0])
    @black.move_stone(@board, :stone => [6,0], :dest => [1,0])
    @black.move_stone(@board, :stone => [1,0], :dest => [0,0])
  end

  it "will deactivate when placed in opponent's home row" do
    @stone.activated?.should == false
  end

  it "will reactivate when placed back in friendly territory" do
    @black.move_stone(@board, :stone => [0,0], :dest => [6,0])
    @stone.activated?.should == true
  end

end