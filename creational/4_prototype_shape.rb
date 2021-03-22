class Shape
  def clone
    raise NotImplementedError, "#{self.class}, not implemented method '#{__method__}'"
  end
end

class Rectangle < Shape
  attr_accessor :width, :height

  def initialize(width: nil, height: nil)
    @height = width
    @width = height
  end

  def clone
    # return Rectangle.new(width: @width, height: @height)
    Marshal.load(Marshal.dump(self))
  end
end

class Circle < Shape
  attr_accessor :x, :y, :radius

  def initialize
    @x = nil
    @y = nil
    @radius = nil
  end

  def clone
    Marshal.load(Marshal.dump(self))
  end
end

if $PROGRAM_NAME == __FILE__
  shapes = []

  circle = Circle.new
  circle.x = 10
  circle.y = 10
  circle.radius = 20
  shapes.append(circle)

  anotherCircle = circle.clone
  shapes.append(anotherCircle)

  rectangle = Rectangle.new
  rectangle.width = 10
  rectangle.height = 20
  shapes.append(rectangle)


  shapes_copy = []

  shapes.each do |shape|
    shapes_copy.append(shape.clone)
  end

  puts shapes.inspect
  puts shapes_copy.inspect
end