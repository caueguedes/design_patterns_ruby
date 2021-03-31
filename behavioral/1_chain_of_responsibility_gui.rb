class ComponentWithContextualHelp
  attr_writer :container
  def show_help
    raise "#{self.class} has not implemented method '#{__method__}'"
  end
end

class AbstractComponent < ComponentWithContextualHelp
  attr_writer :tooltip_help

  def show_help
    if (@tooltip_help != nil)
      @tooltip_help
    else
      @container.show_help
    end
  end
end

class AbstractContainer < ComponentWithContextualHelp
  def initialize
    @children = []
  end

  def add(child)
    @children.append(child)
    child.container = self
  end
end

class Button < AbstractComponent
  def initialize(*args, text)
    @position = *args
    @text = text
  end
end

class Panel < AbstractContainer
  attr_writer :modal_help_text

  def initialize(*args)
    @position = *args
    super()
  end

  def show_help
    if @modal_help_text.nil?
      super
    else
      @modal_help_text
    end
  end
end

class Dialog < AbstractContainer
  attr_writer :wiki_page_url

  def initialize(title)
    @title = title
    super()
  end

  def show_help
    if @wiki_page_url.nil?
      super
    else
      "Opening the wiki help page. #{@wiki_page_url}"
    end
  end
end


if $PROGRAM_NAME == __FILE__
  dialog = Dialog.new("Budget Reports")
  dialog.wiki_page_url = "https://..."

  panel = Panel.new(0, 40, 400, 800)
  panel.modal_help_text = "This panel does..."

  ok = Button.new(250, 760, 50, 20, 'OK')
  ok.tooltip_help = "This is an OK button that..."

  cancel = Button.new(320, 760, 50, 20, "Cancel")
  cancel.tooltip_help = 'This is an Cancel button that...'

  no_tooltip_button = Button.new(300, 50, 50, 20, 'No tooltip Button')

  panel.add(ok)
  panel.add(cancel)
  panel.add(no_tooltip_button)
  dialog.add(panel)

  puts cancel.show_help
  puts ok.show_help
  puts dialog.show_help
  puts panel.show_help
  puts no_tooltip_button.show_help
end
