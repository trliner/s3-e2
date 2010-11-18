class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move_stone(board, opts = {})
    stone_coord = [0,0]
    until board.valid_stone?(self, stone_coord)
      stone_coord = board.random_coordinate
    end
    square = opts[:sqare] || board.random_coordinate
    board.pick_up_stone(stone_coord)
    board.place_stone(square, self.color)
  end

end