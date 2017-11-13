module TS3API
  class ChannelList
    include Command

    def instruction
      "channellist"
    end

    def arguments
      %w(
        -topic
        -flags
        -voice
        -limits
        -icon
      ).join(' ')
    end
  end
end
