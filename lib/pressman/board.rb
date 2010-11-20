module Pressman
  class Board

    include Validation

    attr_accessor :grid
    attr_accessor :stones
    attr_reader :starting_row

    def initialize(color1, color2)
      @grid = Array.new(8).collect{|x| Array.new(8)}
      @stones = {color1 => 0, color2 => 0}
      @starting_row = {color1 => MAX_ROW, color2 => 0}
      place_initial_stones(color1, color2)
    end

    def pick_up_stone(coord)
      stone = stone_at(coord)
      grid[coord.first][coord.last] = nil
      stones[stone.color] -= 1
      stone
    end

    def place_stone(coord, color, stone = nil)
      stone = stone || Stone.new(color)
      grid[coord.first][coord.last] = stone
      stones[color] +=1
    end

    def place_initial_stones(color1, color2)
      BOTTOM_ROWS.each do |row|
        grid[row].each_index { |col| place_stone([row, col], color1) }
      end
      TOP_ROWS.each do |row|
        grid[row].each_index { |col| place_stone([row, col], color2) }
      end
    end

    def color_at(coord)
      contents = grid[coord.first.to_i][coord.last.to_i]
      contents.class == Stone ? contents.color : contents
    end

    def stone_at(coord)
      grid[coord.first.to_i][coord.last.to_i]
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