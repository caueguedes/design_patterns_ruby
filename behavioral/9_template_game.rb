class GameAI
  def initialize
    @resources = []
    @scouts = []
    @warriors = []
  end

  def turn
    collect_resources
    build_structures
    build_units
    attack
  end

  def collect_resources
    build_structures.each { |structure| structure.collect_resources }
  end

  def build_structures
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def build_units
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def attack
    enemy = closest_enemy
    if enemy.nil?
      send_scout(world_map.center)
    else
      send_warriors(enemy.position)
    end
  end

  def send_scout(position)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def send_warriors(position)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class OrcsAI < GameAI
  def build_structures
    if @resources
      # Build farms, then barracks, then stronghold.
    end
  end

  def build_units
    if @resources.length > 10
      if @scouts.empty?
        # Build peon, add it to scouts group.
      else
        # Build grunt, add it to warriors group.
      end
    end

    def send_scouts(position)
      if @scouts.length > 0
        # Send scouts to position.
      end
    end

    def send_warriors(position)
        if @warriors.length > 5
          # Send warriors to position.
        end
    end
  end
end

# Subclasses can also override some operations with a default
# implementation.
class MonstersAI < GameAI
  def collect_resources
    # Monsters don't collect resources.
  end

  def build_structures
    # Monsters don't build structures.
  end

  def build_units
    # Monsters don't build units.
  end
end
