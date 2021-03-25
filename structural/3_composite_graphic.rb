class Graphic
  def move(x, y)
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def draw
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class Dot < Graphic
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(x, y)
    @x += x
    @y += y
  end

  def draw
    "(dot at x:#{@x} y:#{@y})"
  end
end

class Circle < Dot
  attr_accessor :radius

  def initialize(x, y, radius)
    @radius = radius
    super(x, y)
  end

  def draw
    "(circle in #{@x}/#{@y} with radius #{@radius})"
  end
end

class CompoundGraphic < Graphic
  attr_accessor :children

  def initialize
    @children = []
  end

  def add(child)
    @children.append(child)
  end

  def remove(child)
    @children.remove(child)
  end

  def move(x, y)
    @children.each do |child|
      child.mode(x, y)
    end
  end

  def draw
    result = []
    @children.each do |child|
      result.append(child.draw)
    end
    result
  end
end

if $PROGRAM_NAME == __FILE__
  compound = CompoundGraphic.new
  compound.add(Dot.new(1, 2))
  compound.add(Circle.new(5, 3, 10))

  puts "RESULT: #{compound.draw.join(', ')}"
end