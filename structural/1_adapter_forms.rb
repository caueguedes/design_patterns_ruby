class RoundHole
  attr_accessor :radius

  def initialize(radius)
    @radius = radius
  end

  def fits(peg)
    puts @radius >= peg.radius
  end
end

class RoundPeg
  attr_accessor :radius

  def initialize(radius)
    @radius = radius
  end
end

class SquarePeg
  attr_accessor :width

  def initialize(width)
    @width = width
  end
end

class SquarePegAdapter < SquarePeg
  attr_accessor :peg

  def initialize(peg)
    @peg = peg
  end

  def radius
    @peg.width * Math.sqrt(2) / 2
  end
end

if $PROGRAM_NAME == __FILE__
  puts 'Round hole 5 radius with round peg 5 radius'
  hole = RoundHole.new(5)
  round_peg = RoundPeg.new(5)
  hole.fits(round_peg)
  puts "\n"

  small_square_peg = SquarePeg.new(5)
  large_square_peg = SquarePeg.new(10)
  begin
    hole.fits(small_square_peg) # this won't compile (incompatible types)
  rescue NoMethodError
    puts 'No method error raised by incompatibility'
  end
  puts "\n"

  puts 'Round hole 5 radius with square adapted pegs 5 and 10'
  small_square_peg_adapter = SquarePegAdapter.new(small_square_peg)
  large_square_peg_adapter = SquarePegAdapter.new(large_square_peg)

  hole.fits(small_square_peg_adapter) # true
  hole.fits(large_square_peg_adapter) # false
end