class Board

  attr_accessor :columns
  attr_accessor :rows
  attr_accessor :stones

  def initialize
    @columns = (1..8).to_a
    @rows = (1..8).to_a
    @stones = {:black => 1, :white => 1}
  end

end