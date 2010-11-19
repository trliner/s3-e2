describe Stone do

  it "will deactivate when placed in opponent's home row" do
    @black = Player.new(:black)
    @board = Board.new(:black, :white)
    @stone = @board.stone_at([6,0])
    @black.move_stone(@board, :stone => [6,0], :dest => [1,0])
    @black.move_stone(@board, :stone => [1,0], :dest => [0,0])
    @stone.activated?.should == false
  end

end