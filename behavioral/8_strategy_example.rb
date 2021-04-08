class Strategy
  def execute(_a, _b)
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end
end

class ConcreteStrategyAdd < Strategy
  def execute(a, b)
    a + b
  end
end

class ConcreteStrategySubtract < Strategy
  def execute(a, b)
    a - b
  end
end

class ConcreteStrategyMultiply < Strategy
  def execute(a, b)
    a * b
  end
end

class Context
  attr_accessor :strategy

  def initialize(strategy)
    @strategy = strategy
  end

  def execute(a, b)
    @strategy.execute(a, b)
  end
end

if $PROGRAM_NAME == __FILE__
  a, b = 5, 3

  context = Context.new(ConcreteStrategyAdd.new)
  puts 'ConcreteStrategyAdd'
  puts "5 + 3 = #{context.execute(a, b)}"

  puts 'ConcreteStrategySubtract'
  context.strategy = ConcreteStrategySubtract.new
  puts "5 - 3 = #{context.execute(a, b)}"

  puts 'ConcreteStrategyMultiply'
  context.strategy = ConcreteStrategyMultiply.new
  puts "5 * 3 = #{context.execute(a, b)}"
end