class Board

  ELEMENT = (0..7).to_a

  attr_accessor :grid
  attr_accessor :stones

  def initialize(color1, color2)
    @grid = build_grid
    @stones = {color1 => 0, color2 => 0}
    self.place_initial_stones(color1, color2)
  end

  def build_grid
    grid = []
    ELEMENT.each do |row|
      grid[row] = []
      ELEMENT.each do |col|
        grid[row][col] = :empty
      end
    end
    grid
  end

  def pick_up_stone(coord)
    color = self.value_at(coord)
    self.grid[coord.first][coord.last] = :empty
    self.stones[color] -= 1
  end

  def place_stone(coord, color)
    self.grid[coord.first][coord.last] = color
    self.stones[color] +=1
  end

  def place_initial_stones(color1, color2)
    ELEMENT.each do |col|
      self.bottom_rows.each {|row| place_stone([row, col], color1)}
      self.top_rows.each {|row| place_stone([row, col], color2)}
    end
  end

  def top_rows
    [ELEMENT.first, ELEMENT.first + 1]
  end

  def bottom_rows
    [ELEMENT.last - 1, ELEMENT.last]
  end

  def random_coordinate
    [rand(ELEMENT.count), rand(ELEMENT.count)]
  end

  def value_at(coord)
    self.grid[coord.first][coord.last]
  end

  def valid_stone?(player, stone_coord)
    player.color == self.value_at(stone_coord) &&
    !self.valid_destinations(player, stone_coord).empty?
  end

  def valid_dest?(player, stone_coord, dest_coord)
    self.valid_destinations(player, stone_coord).include?(dest_coord)
  end

  def valid_destinations(player, stone_coord)
    self.valid_up_moves(player, stone_coord) +
    self.valid_down_moves(player, stone_coord) +
    self.valid_left_moves(player, stone_coord) +
    self.valid_right_moves(player, stone_coord)
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

  def filter_valid_moves(player, coords)
    moves = []
    catch (:done) do
      coords.each do |coord|
        value = self.value_at(coord)
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
    destinations = self.valid_destinations(player, stone_coord)
    destinations[rand(destinations.count)]
  end

  def random_stone(player)
    stone_coords = []
    ELEMENT.each do |row|
      ELEMENT.each do |col|
        stone_coords << [row, col] if self.value_at([row,col]) == player.color
      end
    end
    stones = stone_coords.select{|coord| self.valid_stone?(player, coord)}
    stones[rand(stones.count)]
  end

end