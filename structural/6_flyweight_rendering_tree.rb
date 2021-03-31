class TreeType
  attr_reader :name, :color, :texture

  def initialize(color, name, texture)
    @color = color
    @name = name
    @texture = texture
  end
end

class TreeFactory
  @tree_types = {}

  def self.get_tree_type (name, color, texture)
    type_key = [ name, color, texture].join('_')
    type = @tree_types[type_key]

    if type.nil?
      type = TreeType.new(name, color, texture)
      @tree_types[type_key] = type
      puts 'Creating new type of tree'
    else
      puts "Reusing #{[name, color, texture].join(", ")} tree"
    end

    type
  end
end

class Tree
  def initialize(x, y, type)
    @x = x
    @y = y
    @type = type
  end

  def draw(canvas)
    "Tree: type (#{@type}) at x(#{@x}, y(#{@y}) on canvas(#{canvas})"
  end
end

class Forest
  def initialize
    @trees = []
  end

  def plant_tree(x, y, name, color, texture)
    type = TreeFactory.get_tree_type(name, color, texture)
    tree = Tree.new(x, y, type)
    @trees.append(tree)
  end

  def draw(canvas)
    @trees.each do |tree|
      tree.draw(canvas)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  forest = Forest.new

  forest.plant_tree(1, 2, 'apple', 'lightgreen', 'type1')
  forest.plant_tree(3, 8, 'pear', 'darkgreen', 'type1')
  forest.plant_tree(10, 11, 'black_ash', 'darkgreen', 'type1')
  forest.plant_tree(20, 23, 'white_ash', 'darkgreen', 'type1')
  forest.plant_tree(30, 26, 'white_ash', 'darkgreen', 'type1')
  forest.plant_tree(15, 6, 'black_ash', 'darkgreen', 'type1')
end