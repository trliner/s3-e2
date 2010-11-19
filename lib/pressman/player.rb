module Pressman
  class Player

    attr_reader :color

    def initialize(color)
      @color = color
    end

    def move_stone(board, opts = {})
      if opts[:resign]
        :resign
      else
        stone_coord = select_stone(board, opts.delete(:stone))
        stone = board.stone_at(stone_coord)
        dest_coord = select_dest(board, stone_coord, opts.delete(:dest))
        stone = board.pick_up_stone(stone_coord)
        if board.color_at(dest_coord) != :empty
          board.pick_up_stone(dest_coord)
        end
        board.place_stone(dest_coord, self.color, stone)
        if on_opposite_side?(board, dest_coord)
          if (
            !empty_starting_squares(board).empty? &&
            stone.activated?
          )
            regenerate_stone(board)
          end
          stone.deactivate
        end
        if in_friendly_territory?(board, dest_coord) && !stone.activated?
          stone.activate
        end
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

    def in_friendly_territory?(board, dest_coord)
      home_row = board.starting_row[self.color]
      (dest_coord.first.to_f - home_row.to_f).abs <= 3
    end

    def empty_starting_squares(board)
      row = board.starting_row[self.color]
      squares = ELEMENT.collect{|col| [row, col]}
      squares.select{|coord| board.color_at(coord) == :empty}
    end

    def regenerate_stone(board)
      squares = self.empty_starting_squares(board)
      regen_coord = squares[rand(squares.count)]
      board.place_stone(regen_coord, self.color)
    end

  end
end