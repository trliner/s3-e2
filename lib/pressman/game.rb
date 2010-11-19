class Game

  attr_accessor :players
  attr_accessor :board
  attr_reader :current_player

  def initialize(player1, player2)
    @players = [player1, player2]
    @board = Board.new(player1.color, player2.color)
  end

  def start
    @current_player = @players.first
  end

  def play_one_turn
    @current_player.move_stone(@board)
    @players.reverse!
    @current_player = @players.first
  end

  def play
    self.start
    winner = nil
    while winner.nil?
      move = self.play_one_turn
      @board.stones.each do |stone|
        winner = self.current_player if (stone.last == 0 || move == :resign)
      end
    end
    winner
  end

end