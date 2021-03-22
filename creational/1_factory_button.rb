# Creator
class Dialog
  def create_button
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def render
    ok_button = create_button
    ok_button.on_click('closeDialog')
    ok_button.render
  end
end

# Concrete Creators
class WindowsDialog < Dialog
  def create_button
    WindowsButton.new
  end
end

# Concrete Creators
class WebDialog < Dialog
  def create_button
    HTMLButton.new
  end
end

# Product interface
class Button
  def render
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def on_click(f)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

# Concrete Product
class WindowsButton < Button
  def render
    'Rendering WindowsButton'
  end

  def on_click(f)
    puts 'Clicking on Windows %s' % f
  end
end

class HTMLButton < Button
  def render
    'Rendering Html Button'
  end

  def on_click(f)
    puts 'Clicking on Html %s' % f
  end
end


if $PROGRAM_NAME == __FILE__
  puts 'Rendering Windows '
  dialog = WindowsDialog.new
  puts dialog.render

  puts 'Rendering HTML'
  dialog = HTMLButton.new
  puts dialog.render
end