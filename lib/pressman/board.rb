class Board

  COLS = (1..8).collect{|n| :"col#{n}"}
  ROWS = (1..8).collect{|n| :"row#{n}"}

  attr_accessor :grid
  attr_accessor :stones

  def initialize(color1, color2)
    @grid = build_grid
    @stones = {color1 => 0, color2 => 0}
    self.place_initial_stones(color1, color2)
  end

  def build_grid
    grid = Board::ROWS.inject({}) do |grid, row|
      col_hash =  Board::COLS.inject({}) { |hash, col| hash.merge(col => nil) }
      grid.merge(row =>col_hash )
    end
  end

  def place_stone(row, col, color)
    self.grid[row][col] = color
    self.stones[color] +=1
  end

  def place_initial_stones(color1, color2)
    COLS.each do |col|
      self.bottom_rows.each {|row| place_stone(row, col, color1)}
      self.top_rows.each {|row| place_stone(row, col, color2)}
    end
  end

  def top_rows
    [ROWS[0], ROWS[1]]
  end

  def bottom_rows
    length = ROWS.length
    [ROWS[length - 1], ROWS[length - 2]]
  end

end