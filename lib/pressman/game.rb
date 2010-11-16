class Game

  attr_accessor :players
  attr_reader :current_player

  def initialize(player1, player2)
    @players = [player1, player2]
  end

  def start
    @current_player = @players.first
  end

end