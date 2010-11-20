module Pressman
  BOARD_SIZE = 8
  MAX_ROW = MAX_COL = BOARD_SIZE - 1
  TOP_ROWS = [0,1]
  BOTTOM_ROWS = [MAX_ROW - 1, MAX_ROW]
end

require 'pressman/validation'
require 'pressman/board'
require 'pressman/player'
require 'pressman/game'
require 'pressman/stone'