class Stone

  attr_reader :color
  attr_accessor :active

  def initialize(color)
    @color = color
    @active = true
  end

  def activated?
    @active
  end

  def deactivate
    @active = false
  end

end