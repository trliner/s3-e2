class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move_stone(board)
    board.place_stone(:row4, :col4, self.color)
  end

end