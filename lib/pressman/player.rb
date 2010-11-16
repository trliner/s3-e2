class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move_stone(board)
    board.pick_up_stone(1, 0)
    board.place_stone(5, 5, self.color)
  end

end