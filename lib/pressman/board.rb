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
      (0..MAX_COL).each do |col|
        BOTTOM_ROWS.each { |row| place_stone([row, col], color1) }
        TOP_ROWS.each {|row| place_stone([row, col], color2) }
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

    def random_stone(player)
      stone_coords = []
      (0..MAX_ROW).each do |row|
        (0..MAX_COL).each do |col|
          stone_coords << [row, col] if color_at([row,col]) == player.color
        end
      end
      stones = stone_coords.select{|coord| valid_stone?(player, coord)}
      stones[rand(stones.count)]
    end

  end
end