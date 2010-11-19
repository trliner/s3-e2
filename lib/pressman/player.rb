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
    if (
      on_opposite_side?(board, dest_coord) &&
      !empty_starting_squares(board).empty?
    )
      regenerate_stone(board)
    end
  end

  def select_stone(board, stone_opt)
    if stone_opt.class == Array && board.valid_stone?(self, stone_opt)
      stone_opt
    else
      board.random_stone(self)
    end
  end

  def select_dest(board, stone_coord, dest_opt)
    if (
      dest_opt.class == Array &&
      board.valid_dest?(self, stone_coord, dest_opt)
    )
      dest_opt
    else
      board.random_destination(self, stone_coord)
    end
  end

  def on_opposite_side?(board, dest_coord)
    row = board.starting_row.select{|k,v| k != self.color}.first.last
    dest_coord.first == row
  end

  def empty_starting_squares(board)
    row = board.starting_row[self.color]
    squares = Board::ELEMENT.collect{|col| [row, col]}
    squares.select{|coord| board.value_at(coord) == :empty}
  end

  def regenerate_stone(board)
    squares = self.empty_starting_squares(board)
    regen_coord = squares[rand(squares.count)]
    board.place_stone(regen_coord, self.color)
  end

end