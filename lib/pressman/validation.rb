module Pressman
  module Validation

    def valid_stone?(player, stone_coord)
      player.color == color_at(stone_coord) &&
      empty_adjacent_space?(stone_coord)
    end

    def valid_dest?(player, stone_coord, dest_coord)
      direction = valid_direction(stone_coord, dest_coord)
      !direction.nil? &&
      valid_square?(player, dest_coord) &&
      valid_path?(direction, stone_coord, dest_coord)
    end

    def color_at(coord)
      contents = grid[coord.first.to_i][coord.last.to_i]
      contents.class == Stone ? contents.color : contents
    end

    def empty_adjacent_space?(stone_coord)
      row, col = stone_coord
      row_range = (row == 0 ? 0 : row-1)..(row == MAX_ROW ? MAX_ROW : row+1)
      row_range.each do |r|
        ((col - 1)..(col + 1)).each do |c|
          return true if stone_at([r,c]) == :empty && [r,c] != [row,col]
        end
      end
      false
    end

    def valid_square?(player, dest_coord)
      contents = color_at(dest_coord)
      contents != player.color && contents != nil
    end

    def valid_path?(direction, stone_coord, dest_coord)
      sorted_rows = [stone_coord.first, dest_coord.first].sort
      sorted_cols = [stone_coord.last, dest_coord.first].sort
      case direction
      when :horizontal
        cols = (sorted_cols.first..sorted_cols.last).to_a
        rows = [stone_coord.first] * cols.size
      when :vertical
        rows = (sorted_rows.first..sorted_rows.last).to_a
        cols = rows.collect{|r| stone_coord.last}
      when :diagonal
        rows = (sorted_rows.first..sorted_rows.last).to_a
        cols = rows.collect{|r| stone_coord.last}
      else
        return false
      end
      path_coords = rows.zip(cols) - [stone_coord, dest_coord]
      empty_path?(path_coords)
    end

    def valid_direction(stone_coord, dest_coord)
      row_diff = stone_coord.first - dest_coord.first
      col_diff = stone_coord.last - dest_coord.last

      return :horizontal if row_diff == 0
      return :vertical if col_diff == 0
      return :diagonal if col_diff.abs == row_diff.abs
      nil
    end

    def empty_path?(path_coords)
      path_coords.each do |coord|
        return false if stone_at(coord) != :empty
      end
      true
    end

  end
end