class GUIFactory
  def create_button
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end

  def create_checkbox
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class WinFactory < GUIFactory
  def create_button
    WinButton.new
  end

  def create_checkbox
    WinCheckbox.new
  end
end

class MacFactory < GUIFactory
  def create_button
    MacButton.new
  end

  def create_checkbox
    MacCheckbox.new
  end
end

class Button
  def paint
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class WinButton < Button
  def paint
    puts 'Render a button in Windows Style'
  end
end

class MacButton < Button
  def paint
    puts 'Render a button in Mac Style'
  end
end

class Checkbox
  def paint
    raise NotImplementedError, "#{self.class}, has not implemented method '#{__method__}'"
  end
end

class WinCheckbox < Checkbox
  def paint
    puts 'Render a checkbox in Windows Style'
  end
end

class MacCheckbox < Checkbox
  def paint
    puts 'Render a checkbox in Mac Style'
  end
end


if $PROGRAM_NAME == __FILE__
  def client_function(factory)
    button = factory.create_button
    button.paint

    checkbox = factory.create_checkbox
    checkbox.paint
  end


  puts 'Using Windows environment'
  factory = WinFactory.new
  client_function(factory)


  puts 'Using Mac environment'
  factory = MacFactory.new
  client_function(factory)




end