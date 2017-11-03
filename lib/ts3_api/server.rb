require 'socket'

module TS3API
  class ConnectionError < StandardError
    attr_reader :ip, :port
    def initialize(ip, port)
      @ip = ip
      @port = port
    end

    def message
      "No TS3 server with IP `#{ip}` on port `#{port}` running."
    end
  end
  class Server
    attr_reader :ip, 
                :port,
                :socket

    DEFAULT_QUERY_PORT = 10011

    ESCAPED_CHARACTERS = [
      { match: '\\\\', replacement: '\\' },
      { match: '\\/', replacement: '/' },
      { match: '\\s', replacement: ' ' },
      { match: '\\p', replacement: '|' },
      { match: '\\a', replacement: '\a' },
      { match: '\\b', replacement: '\b' },
      { match: '\\f', replacement: '\f' },
      { match: '\\n', replacement: '\n' },
      { match: '\\r', replacement: '\r' },
      { match: '\\t', replacement: '\t' },
      { match: '\\v', replacement: '\v' }
    ].freeze

    # @param ip [String] IP address of the server.
    #   By default "localhost".
    # @param port [Integer] port where the query admin
    #   of the server is running.
    def initialize(ip: "localhost", port: DEFAULT_QUERY_PORT)
      @ip   = ip
      @port = port
    end

    def connect
      begin
        @socket = TCPSocket.open(ip, port)
        case socket.gets
        when /TS3/
          TS3API.log 'Connection to query server established'
        else
          raise ConnectionError.new(ip, port)
        end
      end
    end

    def login(sid: nil)
      execute(
        'login', 
        client_login_name: ENV['QUERY_ADMIN_NAME'], 
        client_login_password: ENV['QUERY_ADMIN_PASSWORD']
      )
      use(sid: sid) if sid
      TS3API.log 'Logged in to query server'
    end

    def serverinfo
      execute('serverinfo')
    end

    # @param sid [String] the server id, usually equals "1"
    def use(sid:)
      execute('use', sid: '1') if sid
      TS3API.log "Using sid = #{sid}"
    end

    # @param command [String]
    # @param params [Hash<Symbol, String>]
    def execute(command, params = {})
      command = params.inject(command) do |cmd, param|
        param_name = param[0]
        value = param[1]
        cmd + " #{param_name}=#{encoded_param(value)}"
      end
      socket.puts(command)

      response = ''
      loop do
        response += socket.gets
        break if response.index(' msg=')
      end

      Response.new(response)
    end

    def logout
      execute('quit')
      TS3API.log 'Loging out from query server.'
    end

    def disconnect
      logout
      socket.close
      TS3API.log 'Connection to query server closed'
    end

    private

    def encoded_param(param)
      ESCAPED_CHARACTERS.each do |rule|
        param = param.gsub(
          rule[:match], 
          rule[:replacement]
        )
      end
      param
    end
  end
end
