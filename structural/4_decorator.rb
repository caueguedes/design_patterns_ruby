# The base Component interface defines operations that can be altered by
# decorators.
class Component
  def operation
    raise NoMethodError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

# Concrete Components provide default implementations of the operations. There
# might be several variations of these classes.
class ConcreteComponent < Component
  def operation
    'ConcreteComponent'
  end
end

# The base Decorator class follows the same interface as the other components.
# The primary purpose of this class is to define the wrapping interface for all
# concrete decorators. The default implementation of the wrapping code might
# include a field for storing a wrapped component and the means to initialize
# it.
class Decorator < Component
  attr_accessor :component

  def initialize(component)
    @component = component
  end

  # The Decorator delegates all work to the wrapped component.
  def operation
    @component.operation
  end
end

# Concrete Decorators call the wrapped object and alter its result in some way.
class ConcreteDecoratorA < Decorator
  # Decorators may call parent implementation of the operation, instead of
  # calling the wrapped object directly. This approach simplifies extension of
  # decorator classes.

  def operation
    "ConcreteDecoratorA(#{@component.operation})"
  end
end

# Decorators can execute their behavior either before or after the call to a
# wrapped object.
class ConcreteDecoratorB < Decorator
  def operation
    "ConcreteDecoratorB before"\
    "(#{@component.operation})"\
    "ConcreteDecoratorB after"
  end
end


if $PROGRAM_NAME == __FILE__
  # The client code works with all objects using the Component interface. This way
  # it can stay independent of the concrete classes of components it works with.
  def client_code(component)
    puts "RESULT: #{component.operation}"
  end

  simple = ConcreteComponent.new
  puts 'Client: I\'ve got a simple component:'
  client_code(simple)
  puts "\n"

  # ...as well as decorated ones.
  #
  # Note how decorators can wrap not only simple components but the other
  # decorators as well
  decorator_a = ConcreteDecoratorA.new(simple)
  decorator_b = ConcreteDecoratorB.new(decorator_a)
  puts 'Client: Now I\'ve got a decorated component:'
  client_code(decorator_b)
end
