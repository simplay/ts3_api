module TS3API
  class ClientPoke
    include Command

    def instruction
      'clientpoke'
    end

    def arguments
      clids = args[:ids].map { |clid| "clid=#{clid}"}
      clids.join('|')
    end

    def options
      { 
        msg: Encoder.new(args[:msg]).encode
      }
    end
  end
end
