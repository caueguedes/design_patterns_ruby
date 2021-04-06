class Editor
  attr_accessor :text, :cur_x, :cur_y, :selection_width

  def create_snapshot
    Snapshot.new(this, @text, @cur_x, @cur_y, @selection_width)
  end
end


class Snapshot
  attr_writer :editor
  attr_writer :text, :cur_x, :cur_y, :selection_width

  def initialize(editor, text, cur_x, cur_y, selection_width)
    @editor = editor
    @text = text
    @cur_x = cur_x
    @cur_y = cur_y
    @selection_width = selection_width
  end

  def restore
    @editor.text = text
    @editor.cur_x, @editor.cur_y = @cur_x, @cur_y
    @editor.selection_width = @selection_width
  end
end

class Command
  attr_accessor :backup

  def initialize(editor)
    @editor = editor
  end

  def make_backup
    @backup = @editor.create_snapshot
  end

  def undo
    unless @backup.nil?
      @backup.restore
    end
  end
end