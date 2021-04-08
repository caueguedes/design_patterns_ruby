class AudioPlayer
  def initialize
    @state = ReadyState.new(self)
    @ui = UserInterface.new
    @ui.lock_button(:click_lock)
    @ui.play_button(:click_play)
    @ui.next_button(:click_next)
    @ui.previous_buttonon_click(:click_previous)
  end

  def change_state(state)
    @state = state
  end

  def click_lock
    @state.click_lock
  end

  def click_play
    @state.click_play
  end

  def click_next
    @state.click_next
  end

  def click_previous
    @state.previous
  end

  # A State may call some service methods on the context
  def startPlayback
  end

  def stopPlayback
  end

  def nextSong
  end

  def previousSong
  end

  def fastForward(time)
  end

  def rewind(time)
  end
end

class State
  attr_accessor :player
  private :player

  def initialize(player)
    @player = player
  end

  def click_lock
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def click_play
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def click_next
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def click_previous
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class LockedState < State
  def click_lock
    if @player.playing
      @player.change_state(PlayingState.new(@player))
    else
      @player.change_state(ReadyState.new(@player))
    end
  end

  def clickPlay
  # Locked, so do nothing.
  end

  def clickNext
  # Locked, so do nothing.
  end

  def clickPrevious
  # Locked, so do nothing.
  end
end

class ReadyState < State
  def clickLock() is
    @player.changeState(new LockedState(player))
  end

  def clickPlay() is
    @player.start_playback
    @player.change_state(PlayingState.new(@player))
  end

  def clickNext() is
    @player.next_song
  end
  def clickPrevious() is
    @player.previous_song
  end
end


class PlayingState < State
  def click_lock
    @player.change_state(LockedState.new(@player))
  end

  def click_play
    @player.stop_playback
    @player.change_state(ReadyState.new(@player))
  end

  def click_next
    if event.doubleclick
      @player.next_song
    else
      @player.fast_forward(5)
    end
  end

  def click_previous
    if event.doubleclick
      @player.previous
    else
      @player.rewind(5)
    end
  end
end
