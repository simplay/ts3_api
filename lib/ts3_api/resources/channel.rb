module TS3API
  class Channel
    def self.all
      response = ChannelList.new.execute
      response.attributes.map do |channel_attributes|
        new(channel_attributes)
      end
    end

    def self.find(pattern: "")
      all.select do |channel| 
        channel.name.match? pattern 
      end
    end

    attr_reader :id,
                :pid,
                :order,
                :name,
                :topic,
                :total_clients,
                :max_clients,
                :needed_talk_power

    def initialize(attributes = {})
      @id                = attributes[:cid]
      @pid               = attributes[:pid]
      @order             = attributes[:channel_order]
      @name              = attributes[:channel_name]
      @topic             = attributes[:channel_topic]
      @needed_talk_power = attributes[:channel_needed_talk_power]
      @total_clients     = attributes[:total_clients]
      @max_clients       = attributes[:channel_maxclients]
    end
  end
end
