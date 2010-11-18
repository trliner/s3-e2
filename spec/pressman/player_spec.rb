describe Player do

  it "has a color" do
    color = :black
    player = Player.new(color)
    player.color.should == color
  end

  it "can capture another player's stone" do
    @black = Player.new(:black)
    @white = Player.new(:white)
    @board = Board.new(:black, :white)

    white_stone_count = @board.stones[:white]
    black_stone_count = @board.stones[:black]
    @black.move_stone(@board, :stone => [6,0], :dest => [1,0])
    @board.stones[:white].should == white_stone_count - 1
    @white.move_stone(@board, :stone => [1,7], :dest => [6,7])
    @board.stones[:black].should == black_stone_count - 1
  end

end