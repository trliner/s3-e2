describe Game do

  before do
    @black = Player.new(:black)
    @white = Player.new(:white)
    @game = Game.new(@black, @white)
    @game.start
  end

  it "starts with black as the first player" do
    @game.current_player.should == @black
  end

  it "alternates players each turn" do
    @game.current_player.should == @black
    @game.play_one_turn
    @game.current_player.should == @white
    @game.play_one_turn
    @game.current_player.should == @black
  end

  it "requires current player to move a stone on each turn" do
    original_grid = Marshal.load(Marshal.dump(@game.board.grid))
    @game.play_one_turn
    @game.board.grid.should_not == original_grid
  end

  it "will declare a winner if the opponent runs out of stones" do
    @game.play.class.should == Player
  end

  it "will declare a winner if the opponent resigns" do
    @game.play_one_turn.should == @white
  end

  it "will declare a winner if the opponent resigns" do
    @game.play_one_turn
    @game.play_one_turn.should == @black
  end
end