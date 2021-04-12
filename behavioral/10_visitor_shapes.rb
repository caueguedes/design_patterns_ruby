class Shape
  def move(_x, _y)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def draw
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def accept(_visitor)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Dot < Shape
  def accept(visitor)
    visitor.visit_dot(self)
  end
end

class Circle < Shape
  def accept(visitor)
    visitor.visit_circle(self)
  end
end

class Rectangle < Shape
  def accept(visitor)
    visitor.visit_rectangle(self)
  end
end

class CompoundShape < Shape
  def accept(visitor)
    visitor.visit_compound_shape(self)
  end
end

class Visitor
  def visit_dot(_dot)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_circle(_circle)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_rectangle(_rectangle)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_compound_shape(_compound)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class XMLExportVisitor < Visitor
  def visit_dot(dot)
    puts "#{dot.class} + #{self.class}"
  end

  def visit_circle(circle)
    puts "#{circle.class} + #{self.class}"
  end

  def visit_rectangle(rectangle)
    puts "#{rectangle.class} + #{self.class}"
  end

  def visit_compound_shape(compound)
    puts "#{compound.class} + #{self.class}"
  end
end

if $PROGRAM_NAME == __FILE__
  all_shapes = [Circle.new, Rectangle.new, CompoundShape.new]
  export_visitor = XMLExportVisitor.new

  all_shapes.each do |shape|
    shape.accept(export_visitor)
  end
end