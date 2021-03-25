class RemoteControl
  def initialize(device)
    @device = device
  end

  def toggle_power
    puts "Device toggled #{@device.enabled? ? 'Off' : 'On'}"
    return @device.disable if @device.enabled?
    @device.enable
  end

  def volume_down
    @device.volume -= 10
    puts "Device volume : #{@device.volume}"
  end

  def volume_up
    @device.volume += 10
    puts "Device volume : #{@device.volume}"
  end

  def channel_up
    @device.channel += 1
    puts "Device channel : #{@device.channel}"
  end

  def channel_down
    @device.channel -= 1
    puts "Device channel : #{@device.channel}"
  end
end

class AdvancedRemoteControl < RemoteControl
  def mute
    @device.volume = 0
    puts "Device Volume Muted"
  end
end

class Device
  def enabled?
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def enable
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def disable
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def volume=(volume)
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def volume
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def channel=(channel)
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def channel
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class Tv < Device
  attr_accessor :volume, :channel

  def initialize
    @channel = 0
    @enabled = false
    @volume = 0
  end

  def enabled?
    @enabled
  end

  def enable
    @enabled = true
  end

  def disable
    @enabled = false
  end
end

class Radio < Device
  attr_accessor :volume, :channel

  def initialize
    @channel = 0
    @enabled = false
    @volume = 0
  end

  def enabled?
    @enabled
  end

  def enable
    @enabled = true
  end

  def disable
    @enabled = false
  end
end

if $PROGRAM_NAME == __FILE__
  tv = Tv.new
  remote = RemoteControl.new(tv)
  remote.toggle_power
  remote.volume_up
  remote.volume_down
  begin
    remote.mute
  rescue NoMethodError
    puts 'Rescue from an error'
  end

  radio = Radio.new
  remote = AdvancedRemoteControl.new(radio)
  remote.toggle_power
  remote.volume_up
  remote.volume_down
  remote.mute
end
