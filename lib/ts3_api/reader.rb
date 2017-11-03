module TS3API
  class Reader
    attr_reader :connection, :queue

    def initialize(ip:, port:, queue:)
      @connection = Connection.new(ip: ip, port: port)
      @queue = queue
      @running = false
    end

    def running?
      @running
    end

    def run
      @running = true
      Thread.start do 
        while message = connection.get
          response = Response.new(message)
          queue << response
          break unless running?
        end
      end
    end

    def stop
      @running = false
    end
  end
end
