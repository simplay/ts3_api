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

    attr_reader :id,
                :channel_id,
                :nickname,
                :unique_id,
                :platform

    def initialize(attributes = {})
      @id         = attributes[:clid]
      @channel_id = attributes[:cid]
      @nickname   = attributes[:nickname]
      @unique_id  = attributes[:client_unique_identifier]
      @platform   = attributes[:client_platform]
    end
  end
end
