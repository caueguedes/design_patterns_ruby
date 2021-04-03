class Command
  def initialize(app, editor)
    @app = app
    @backup = ''
    @editor = editor
  end

  def save_backup
    @editor.text = @backup
  end

  def undo
    @editor.text = @backup
  end

  def execute
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end


class CopyCommand < Command
  def execute
    @app.clipboard = @editor.get_selection
    false
  end
end


class CutCommand < Command
  def execute
    save_backup
    @app.clipboard = @editor.get_selection
    @editor.delete_selection
    true
  end
end


class PasteCommand < Command
  def execute
    save_backup
    @editor.replace_selection(@app.clipboard)
    true
  end
end


class UndoCommand < Command
  def execute
    @app.undo
    return false
  end
end


class CommandHistory
  def initialize
    @history = []
  end

  def push(command)
    @history.push(command)
  end

  def pop
    @history.pop
  end
end


class Editor
  def initialize
    @text = ''
  end

  def get_selection
    # Return Selected Text
  end

  def delete_selection
    # Delete Selected Text
  end

  def replace_selection
    # Insert current clipboard at the current position
  end
end
