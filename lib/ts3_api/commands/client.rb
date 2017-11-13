module TS3API
  class Client
    def self.all
      options = %w(
        -uid 
        -away 
        -voice 
        -times 
        -groups 
        -info 
        -icon 
        -country
      )
      response = Server.execute("clientlist #{options.join(' ')}")
      response.attributes.map do |client_attributes|
        new(client_attributes)
      end
    end

    # Example
    #   kick client with clid 5
    #   Client.kick_from_server(["5"])
    #   
    # @param client_ids [Array<String>] client ids
    def self.kick_from_server(client_ids, reason_msg = "")
      clids = client_ids.map do |client_id|
        "clid=#{client_id}"
      end
      kick_command = "clientkick #{clids.join('|')}"

      params = { 
        reasonid: "5",
        reasonmsg: Encoder.new(reason_msg).encode
      }
      Server.execute(kick_command, params)
    end

    # Client.poke("2", "Hey you")
    def self.poke(client_id, msg = "")
      encoded_msg = Encoder.new(msg).encode
      Server.execute("clientpoke clid=#{client_id} msg=#{encoded_msg}")
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
