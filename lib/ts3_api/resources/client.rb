module TS3API
  class Client
    def self.all
      response = ClientList.new.execute
      response.attributes.map do |client_attributes|
        new(client_attributes)
      end
    end

    # Example
    #   kick client with clid 5
    #   Client.kick_from_server("5")
    #   
    # @param client_ids [String, Array<String>] client ids
    def self.kick_from_server(client_ids, reason_msg = "")
      ClientKick.new(
        ids: Array(client_ids), 
        msg: reason_msg
      ).execute
    end

    # Client.poke(1, "Hey you")
    # @param client_ids [String, Integer, Array<String,Integer>]
    def self.poke(client_ids, msg = "")
      ClientPoke.new(
        ids: Array(client_ids).map(&:to_s), 
        msg: msg
      ).execute
    end

    attr_reader :id,
                :channel_id,
                :nickname,
                :type,
                :away,
                :unique_id,
                :platform,
                :version,
                :talk_power

    def initialize(attributes = {})
      @id         = attributes[:clid]
      @channel_id = attributes[:cid]
      @nickname   = attributes[:client_nickname]
      @type       = attributes[:client_type]
      @away       = attributes[:client_away]
      @unique_id  = attributes[:client_unique_identifier]
      @platform   = attributes[:client_platform]
      @version    = attributes[:client_version]
      @talk_power = attributes[:client_talk_power]
    end

    def away?
      away == 1
    end

    def poke(msg = "")
      Client.poke(id, msg)
    end

    def kick_from_server(msg = "")
      Client.kick_from_server([id], msg)
    end
  end
end
