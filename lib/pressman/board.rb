module Pressman
  class Board

    include Validation

    attr_accessor :grid
    attr_accessor :stones
    attr_reader :starting_row

    def initialize(color1, color2)
      @grid = build_grid
      @stones = {color1 => 0, color2 => 0}
      @starting_row = {color1 => ELEMENT.last, color2 => ELEMENT.first}
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
      stone = self.stone_at(coord)
      self.grid[coord.first][coord.last] = :empty
      self.stones[stone.color] -= 1
      stone
    end

    def place_stone(coord, color, stone = nil)
      stone = stone || Stone.new(color)
      self.grid[coord.first][coord.last] = stone
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

    def color_at(coord)
      contents = self.grid[coord.first.to_i][coord.last.to_i]
      contents.class == Stone ? contents.color : contents
    end

    def stone_at(coord)
      self.grid[coord.first.to_i][coord.last.to_i]
    end

    def random_destination(player, stone_coord)
      destinations = self.valid_destinations(player, stone_coord)
      destinations[rand(destinations.count)]
    end

    def random_stone(player)
      stone_coords = []
      ELEMENT.each do |row|
        ELEMENT.each do |col|
          stone_coords << [row, col] if self.color_at([row,col]) == player.color
        end
      end
      stones = stone_coords.select{|coord| self.valid_stone?(player, coord)}
      stones[rand(stones.count)]
    end

  end
end