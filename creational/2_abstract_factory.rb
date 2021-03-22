# The Abstract Factory interface declares a set of methods that return different
# abstract products. These products are called a family and are related by a
# high-level theme or concept. Products of one family are usually able to
# collaborate among themselves. A family of products may have several variants,
# but the products of one variant are incompatible with products of another.
class AbstractFactory
  def create_product_a
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def create_product_b
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

# Concrete Factories produce a family of products that belong to a single
# variant. The factory guarantees that resulting products are compatible. Note
# that signatures of the Concrete Factory's methods return an abstract product,
# while inside the method a concrete product is instantiated.
class ConcreteFactory1 < AbstractFactory
  def create_product_a
    ConcreteProductA1.new
  end

  def create_product_b
    ConcreteProductB1.new
  end
end

class ConcreteFactory2 < AbstractFactory
  def create_product_a
    ConcreteProductA2.new
  end

  def create_product_b
    ConcreteProductB2.new
  end
end

# Each distinct product of a product family should have a base interface. All
# variants of the product must implement this interface.
class AbstractProductA
  def useful_function_a
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteProductA1 < AbstractProductA
  def useful_function_a
    'The result of the product A1.'
  end
end

class ConcreteProductA2 < AbstractProductA
  def useful_function_a
    'The result of the product A2'
  end
end

class AbstractProductB
  def useful_function_b
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def another_useful_function_b(collaborator)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteProductB1 < AbstractProductB
  def useful_function_b
    'The result of the product B1.'
  end

  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "The result of the B1 collaborating with the (#{result})"
  end
end

class ConcreteProductB2 < AbstractProductB
  def useful_function_b
    'The result of the product B2.'
  end

  def another_useful_function_b(collaborator)
    result = collaborator.useful_function_a
    "The result of the B2 collaborating with the (#{result})"
  end
end


if $PROGRAM_NAME == __FILE__
  def client_code(factory)
    product_a = factory.create_product_a
    product_b = factory.create_product_b

    puts product_b.useful_function_b.to_s
    puts product_b.another_useful_function_b(product_a).to_s
  end

  puts 'Client: Testing client code with the first factory type:'
  client_code(ConcreteFactory1.new)

  puts 'Client: Testing the same client code with the second factory type:'
  client_code(ConcreteFactory2.new)
end