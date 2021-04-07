class EventManager
  def initialize
    @listeners = {}
  end

  def subscribe(event_type, listener)
    @listeners[event_type] = [] unless @listeners.has_key? event_type
    @listeners[event_type] << listener
  end

  def unsubscribe(event_type, listener)
    @listeners[event_type].delete(listener)
    @listeners.delete(event_type) if @listeners[event_type].empty?
  end

  def notify(event_type, data)
    @listeners[event_type].each { |listener| listener.update(data) }
  end
end


class Editor
  attr_reader :events
  def initialize
    @events = EventManager.new
  end

  def open_file(path)
    @file = File.new(path)
    @events.notify("open", @file.name)
  end

  def save_file
    @file.write ''
    @events.notify("save", file.name)
  end
end

class EventListener
  def update(_filename)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class LoggingListener < EventListener
  def initialize(log, message)
    @log = log
    @message = message
  end

  def update(filename)
    @log.write(replace('%s', filename, @message))
    puts "Logging to #{filename}, #{@message}"
  end
end

class EmailAlertsListener < EventListener
  def initialize(email, message)
    @email = email
    @message = message
  end

  def update(filename)
    puts "Sending Email to #{@email}, #{filename} #{@message}"
  end
end


if $PROGRAM_NAME == __FILE__
  editor = Editor.new

  logger = LoggingListener.new(
                 "/path/to/log.txt",
                 "Someone has opened the file: %s")

  editor.events.subscribe("open", logger)

  emailAlerts = EmailAlertsListener.new(
                      "admin@example.com",
                      "Someone has changed the file: %s")

  editor.events.subscribe("save", emailAlerts)
end