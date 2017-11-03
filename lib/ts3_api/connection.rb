require 'socket'

module TS3API
  class Connection
    attr_reader :ip, 
                :port,
                :socket

    # @param ip [String] IP address of the server.
    #   By default "localhost".
    # @param port [Integer] port where the query admin
    #   of the server is running.
    def initialize(ip: "localhost", port: Server::DEFAULT_QUERY_PORT)
      @ip   = ip
      @port = port
      @socket = TCPSocket.open(ip, port)
    end

    def send(message)
      socket.puts message
    end

    def get
      socket.gets
    end

    def close
      socket.close
    end
  end
end
