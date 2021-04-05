class SocialNetwork
  def create_friends_iterator(profile_id)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def create_coworkers_iterator(profile_id)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class Facebook < SocialNetwork
  def create_friends_iterator(profile_id)
    FacebookIterator(self, profile_id, "friends")
  end

  def create_coworkers_iterator(profile_id)
    FacebookIterator(self, profile_id, "coworkers")
  end
end

class ProfileIterator
  def get_next
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def has_more?
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class FacebookIterator < ProfileIterator
  def initialize(facebook, profile_id, type = 'friends')
    @facebook = facebook
    @profile_id = profile_id
    @type = type
    @currentPosition = 0
  end

  private
    def lazy_init
      @cache |= @facebook.social_graph_request(@profile_id, @type)
    end

    def get_next
      if has_more?
        @currentPosition += 1
        @cache[@currentPosition]
      end
    end

    def has_more?
      lazy_init
      @currentPosition < @cache.length
    end
end

class SocialSpammer
  def send(iterator, message)
    while iterator.has_more? do
      profile = iterator.get_next
      puts profile.get_email, message
    end
  end
end

if $PROGRAM_NAME == __FILE__
  network = Facebook.new
  # network = LinkedIn.new

  spammer = SocialSpammer.new

  # Spam Friends
  iterator = network.create_friends_iterator(profile.getId())
  spammer.send(iterator, "Very important message")

  # Spam Coworkers
  iterator = network.create_coworkers_iterator(profile.getId())
  spammer.send(iterator, "Very important message")
end