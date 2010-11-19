module Pressman
  module Validation

  def valid_stone?(player, stone_coord)
    player.color == self.color_at(stone_coord) &&
    !self.valid_destinations(player, stone_coord).empty?
  end

  def valid_dest?(player, stone_coord, dest_coord)
    self.valid_destinations(player, stone_coord).include?(dest_coord)
  end

  def valid_destinations(player, stone_coord)
    self.valid_up_moves(player, stone_coord) +
    self.valid_down_moves(player, stone_coord) +
    self.valid_left_moves(player, stone_coord) +
    self.valid_right_moves(player, stone_coord) +
    self.valid_up_right_moves(player, stone_coord) +
    self.valid_down_right_moves(player, stone_coord) +
    self.valid_up_left_moves(player, stone_coord) +
    self.valid_down_left_moves(player, stone_coord)
  end

  def valid_up_moves(player, stone_coord)
    row, col = stone_coord
    rows = ELEMENT.to_a.select{|e| e < row}
    coords = rows.reverse.collect{|r| [r, col]}
    self.filter_valid_moves(player, coords)
  end

  def valid_down_moves(player, stone_coord)
    row, col = stone_coord
    rows = ELEMENT.to_a.select{|e| e > row}
    coords = rows.collect{|r| [r, col]}
    self.filter_valid_moves(player, coords)
  end

  def valid_left_moves(player, stone_coord)
    row, col = stone_coord
    cols = ELEMENT.to_a.select{|e| e < col}
    coords = cols.reverse.collect{|c| [row, c]}
    self.filter_valid_moves(player, coords)
  end

  def valid_right_moves(player, stone_coord)
    row, col = stone_coord
    cols = ELEMENT.to_a.select{|e| e > col}
    coords = cols.collect{|c| [row, c]}
    self.filter_valid_moves(player, coords)
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
    self.filter_valid_moves(player, coords)
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
    self.filter_valid_moves(player, coords)
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
    self.filter_valid_moves(player, coords)
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
    self.filter_valid_moves(player, coords)
  end

  def filter_valid_moves(player, coords)
    moves = []
    catch (:done) do
      coords.each do |coord|
        value = self.color_at(coord)
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

  end
end