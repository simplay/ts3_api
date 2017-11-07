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
                :connection,
                :server_responses

    DEFAULT_QUERY_PORT = 10011
    DEFAULT_SID = "1".freeze

    def self.instance(*args)
      @instance ||= send(:new, *args)
    end

    # connect and login to the server
    def self.start
      instance.connect
      instance.login
    end

    # logout and disconnect from the server and
    # destroy the state of the server singleton
    def self.stop
      instance.disconnect
      instance.destroy
    end

    def self.execute(command, params = {})
      instance.execute(command, params)
    end

    def self.responses
      instance.server_responses
    end

    def self.info
      execute('serverinfo')
    end

    private_class_method :new

    # @param ip [String] IP address of the server.
    #   By default "localhost".
    # @param port [Integer] port where the query admin
    #   of the server is running.
    def initialize(ip: "localhost", port: DEFAULT_QUERY_PORT)
      @ip   = ip
      @port = port
      @server_responses = []
    end

    def destroy
      @instance = nil
    end

    def connect
      begin
        @connection = Connection.new(ip: ip, port: port)
        @reader = Reader.new(
          ip: ip,
          port: port,
          queue: server_responses
        )
        case connection.get
        when /TS3/
          TS3API.log 'Connection to query server established'
        else
          raise ConnectionError.new(ip, port)
        end
      end
    end

    def login(sid: DEFAULT_SID)
      execute(
        'login', 
        client_login_name: ENV['QUERY_ADMIN_NAME'], 
        client_login_password: ENV['QUERY_ADMIN_PASSWORD']
      )
      use(sid: sid) if sid
      @reader.run
      TS3API.log 'Logged in to query server'
    end

    # @param sid [String] the server id, usually equals "1"
    def use(sid:)
      execute('use', sid: sid) if sid
      TS3API.log "Using sid = #{sid}"
    end

    # @param command [String]
    # @param params [Hash<Symbol, String>]
    def execute(command, params = {})
      command = params.inject(command) do |cmd, param|
        param_name = param[0]
        value = param[1]
        cmd + " #{param_name}=#{Decoder.new(value).decode}"
      end
      connection.send(command)

      response = ''
      loop do
        response += connection.get
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
      connection.close
      @reader.stop
      TS3API.log 'Connection to query server closed'
    end
  end
end
