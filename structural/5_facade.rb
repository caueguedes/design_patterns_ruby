# The Facade class provides a simple interface to the complex logic of one or
# several subsystems. The Facade delegates the client requests to the
# appropriate objects within the subsystem. The Facade is also responsible for
# managing their lifecycle. All of this shields the client from the undesired
# complexity of the subsystem.
class Facade
  # Depending on your application's needs, you can provide the Facade with
  # existing subsystem objects or force the Facade to create them on its own.
  def initialize(subsystem1, subsystem2)
    @subsystem1 = subsystem1 || Subsystem1.new
    @subsystem2 = subsystem2 || Subsystem2.new
  end

  # The Facade's methods are convenient shortcuts to the sophisticated
  # functionality of the subsystems. However, clients get only to a fraction of
  # a subsystem's capabilities.
  def operation
    results = []
    results.append('Facade initializes subsystems:')
    results.append(@subsystem1.operation1)
    results.append(@subsystem2.operation1)

    results.append('Facade orders subsystems to perform the action:')
    results.append(@subsystem1.operation2)
    results.append(@subsystem2.operation2)

    results.join("\n")
  end
end

# The Subsystem can accept requests either from the facade or client directly.
# In any case, to the Subsystem, the Facade is yet another client, and it's not
# a part of the Subsystem.
class Subsystem1
  def operation1
    'Subsystem1: Ready!'
  end

  def operation2
    'Subsystem1: Go!'
  end
end

# Some facades can work with multiple subsystems at the same time.
class Subsystem2
  def operation1
    'Subsystem2: Ready!'
  end

  def operation2
    'Subsystem2: Fire!'
  end
end

if $PROGRAM_NAME == __FILE__
  # The client code works with complex subsystems through a simple interface
  # provided by the Facade. When a facade manages the lifecycle of the subsystem,
  # the client might not even know about the existence of the subsystem. This
  # approach lets you keep the complexity under control.
  def client_code(facade)
    print facade.operation
  end

  subsystem1 = Subsystem1.new
  subsystem2 = Subsystem2.new

  facade = Facade.new(subsystem1, subsystem2)
  client_code(facade)
end