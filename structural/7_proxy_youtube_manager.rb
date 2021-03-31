class ThirdPartyYoutubeLib
  def list_videos
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def get_video_info(id)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def download_video(id)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class CachedYoutubeClass < ThirdPartyYoutubeLib
  @list_cache = nil
  @video_cache = nil
  @need_reset = false

  def initialize(service)
    @service = service
  end

  def list_videos
    if @list_cache.nil? || @need_reset
      @list_cache = @service.list_videos
    end
    @list_cache
  end

  def get_video_info(id)
    if @video_cache.nil? || @need_reset
      @video_cache = @service.get_video_info(id)
    end
    @video_cache
  end

  def download_video(id)
    video = download_exists(id)
    if !video || @need_reset
      service.download_video(id)
    end
    video
  end

  def download_exists(id)
    puts 'Checking if video is already downloaded'
  end
end

class YoutubeManager
  def initialize(service)
    @service = service
  end

  def render_video_page(id)
    info = @service.get_video_info(id)
    puts 'Rendering video page'
  end


end