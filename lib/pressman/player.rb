module Pressman
  class Player

    attr_reader :color

    def initialize(color)
      @color = color
    end

    def move_stone(board, opts = {})
      return :resign if opts[:resign]
      stone_coord = select_stone(board, opts.delete(:stone))
      stone = board.pick_up_stone(stone_coord)
      dest_coord = select_dest(board, stone_coord, opts.delete(:dest))
      capture_stone(board, dest_coord)
      board.place_stone(dest_coord, color, stone)
      if on_opposite_side?(board, dest_coord) && stone.activated?
        regenerate_stone(board, stone)
      end
      if in_friendly_territory?(board, dest_coord) && !stone.activated?
        stone.activate
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
      row = board.starting_row.select{|k,v| k != color}.first.last
      dest_coord.first == row
    end

    def in_friendly_territory?(board, dest_coord)
      home_row = board.starting_row[color]
      (dest_coord.first.to_f - home_row.to_f).abs <= 3
    end

    def empty_starting_squares(board)
      row = board.starting_row[color]
      squares = (0..MAX_COL).collect{ |col| [row, col] }
      squares.select{ |coord| board.color_at(coord).nil? }
    end

    def regenerate_stone(board, stone)
      squares = empty_starting_squares(board)
      regen_coord = squares[rand(squares.count)]
      board.place_stone(regen_coord, color) if regen_coord
      stone.deactivate
    end

    def capture_stone(board, dest_coord)
      unless board.color_at(dest_coord).nil?
        board.pick_up_stone(dest_coord)
      end
    end

  end
end