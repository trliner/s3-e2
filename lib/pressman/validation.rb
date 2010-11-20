module Pressman
  module Validation

  def valid_stone?(player, stone_coord)
    player.color == color_at(stone_coord) &&
    !valid_destinations(player, stone_coord).empty?
  end

  def valid_dest?(player, stone_coord, dest_coord)
    valid_destinations(player, stone_coord).include?(dest_coord)
  end

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
    while row >= 0 && col <= 7
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
    while row <=7 && col <= 7
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
    while row <= 7 && col >= 0
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
        when nil
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

  end
end