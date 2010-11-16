describe Player do

  it "has a color" do
    color = :black
    player = Player.new(color)
    player.color.should == color
  end

end