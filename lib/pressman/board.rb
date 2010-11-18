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
        grid[row][col] = nil
      end
    end
    grid
  end

  def pick_up_stone(coord)
    color = self.grid[coord.first][coord.last]
    self.grid[coord.first][coord.last] = nil
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

  def valid_stone?(player, coord)
    player.color == self.grid[coord.first][coord.last]
  end

end