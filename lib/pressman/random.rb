module Pressman
  module Random

    def valid_destinations(player, stone_coord)
      valid_up_moves(player, stone_coord) +
      valid_down_moves(player, stone_coord) +
      valid_left_moves(player, stone_coord) +
      valid_right_moves(player, stone_coord) +
      valid_up_right_moves(player, stone_coord) +
      valid_down_right_moves(player, stone_coord) +
      valid_up_left_moves(player, stone_coord) +
      valid_down_left_moves(player, stone_coord)
    end

    def valid_up_moves(player, stone_coord)
      row, col = stone_coord
      rows = (0...row).to_a
      coords = rows.reverse.collect{|row| [row, col]}
      filter_valid_moves(player, coords)
    end

    def valid_down_moves(player, stone_coord)
      row, col = stone_coord
      rows = ((row + 1)..MAX_ROW).to_a
      coords = rows.collect{|row| [row, col]}
      filter_valid_moves(player, coords)
    end

    def valid_left_moves(player, stone_coord)
      row, col = stone_coord
      cols = (0...col).to_a
      coords = cols.reverse.collect{|col| [row, col]}
      filter_valid_moves(player, coords)
    end

    def valid_right_moves(player, stone_coord)
      row, col = stone_coord
      cols = ((col + 1)..MAX_COL).to_a
      coords = cols.collect{|col| [row, col]}
      filter_valid_moves(player, coords)
    end

    def valid_up_right_moves(player, stone_coord)
      row, col = stone_coord
      coords = []
      row -= 1
      col += 1
      while row >= 0 && col <= MAX_ROW
        coords << [row, col]
        row -= 1
        col += 1
      end
      filter_valid_moves(player, coords)
    end

    def valid_down_right_moves(player, stone_coord)
      row, col = stone_coord
      coords = []
      row += 1
      col += 1
      while row <= MAX_ROW && col <= MAX_COL
        coords << [row, col]
        row += 1
        col += 1
      end
      filter_valid_moves(player, coords)
    end

    def valid_up_left_moves(player, stone_coord)
      row, col = stone_coord
      coords = []
      row -= 1
      col -= 1
      while row >= 0 && col >= 0
        coords << [row, col]
        row -= 1
        col -= 1
      end
      filter_valid_moves(player, coords)
    end

    def valid_down_left_moves(player, stone_coord)
      row, col = stone_coord
      coords = []
      row += 1
      col -= 1
      while row <= MAX_ROW && col >= 0
        coords << [row, col]
        row += 1
        col -= 1
      end
      filter_valid_moves(player, coords)
    end

    def filter_valid_moves(player, coords)
      moves = []
      catch (:done) do
        coords.each do |coord|
          value = color_at(coord)
          case value
          when :empty
            moves << coord
          when player.color
            throw :done
          else
            moves << coord
            throw :done
          end
        end
      end
      moves
    end

    def random_destination(player, stone_coord)
      destinations = valid_destinations(player, stone_coord)
      destinations[rand(destinations.count)]
    end

    def random_stone_coord(player)
      stone_coords = []
      grid.each_with_index do |col_array, row|
        col_array.each_index do |col|
          stone_coords << [row, col] if valid_stone?(player, [row,col])
        end
      end
      stone_coords[rand(stone_coords.count)]
    end

  end
end