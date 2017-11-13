module TS3API
  class ClientKick
    include Command

    def instruction
      'clientkick'
    end

    def arguments
      clids = args[:ids].map { |clid| "clid=#{clid}"}
      clids.join('|')
    end

    def options
      { 
        reasonid: '5',
        reasonmsg: Encoder.new(args[:msg]).encode
      }
    end
  end
end
