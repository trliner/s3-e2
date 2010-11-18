class Player

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def move_stone(board, opts = {})
    stone_coord = select_stone(board, opts.delete(:stone))
    dest_coord = select_dest(board, stone_coord, opts.delete(:dest))
    board.pick_up_stone(stone_coord)
    if board.value_at(dest_coord) != :empty
      board.pick_up_stone(dest_coord)
    end
    board.place_stone(dest_coord, self.color)
  end

  def select_stone(board, stone_opt)
    if stone_opt.class == Array && board.valid_stone?(self, stone_opt)
      stone_opt
    else
      board.random_stone(self)
    end
  end

  def select_dest(board, stone_coord, dest_opt)
    if dest_opt.class == Array && board.valid_dest?(self, stone_coord, dest_opt)
      dest_opt
    else
      board.random_destination(self, stone_coord)
    end
  end

end