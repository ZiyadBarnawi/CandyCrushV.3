class Orbs
  attr_reader :color

  def initialize(color=nil)
    if(color!=nil)
      @color=color.strip()
      return
    end

    case rand(0..4)
    when 0
      @color="Red"
    when 1
      @color="Blue"
    when 2
      @color="purple"
    when 3
      @color="Yellow"
    when 4
      @color="Green"
    end
  end

  def ==(other)
    self.color==other.color
  end
  def to_s
    return self.color
  end
end


