class Board

  attr_accessor :grid
  attr_accessor :stones

  def initialize
    @grid = build_grid
    @stones = {:black => 1, :white => 1}
  end

  def build_grid
    col_hash = {}
    (1..8).each {|n| col_hash[:"col#{n}"] = nil}
    grid = {}
    (1..8).each {|n| grid[:"row#{n}"] = col_hash}
    grid
  end

end