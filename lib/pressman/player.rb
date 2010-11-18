class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move_stone(board, opts = {})
    stone_coord = board.random_stone(self)
    dest_coord = board.random_destination(self, stone_coord)
    board.pick_up_stone(stone_coord)
    board.place_stone(dest_coord, self.color)
  end

end