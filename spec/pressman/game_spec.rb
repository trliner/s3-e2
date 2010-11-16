describe Game do

  before do
    @black = Player.new(:black)
    @white = Player.new(:white)
    @game = Game.new(@black, @white)
  end

  it "starts with black as the first player" do
    @game.start
    @game.current_player.should == @black
  end

  it "should alternate players each turn" do
    @game.start
    @game.current_player.should == @black
    @game.play_one_turn
    @game.current_player.should == @white
    @game.play_one_turn
    @game.current_player.should == @black
  end

end