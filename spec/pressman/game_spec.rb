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

end