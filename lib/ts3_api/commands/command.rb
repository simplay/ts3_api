module TS3API
  module Command
    attr_reader :args

    # @param args [Hash]
    def initialize(args = {})
      @args = args
    end

    # @return [String] instruction string
    def instruction
      raise NotImplementedError
    end

    # @return [Hash] options hash
    def options
      {}
    end

    # Command arguments
    # @return [String] argument string
    def arguments
      ""
    end

    # @return [Response]
    def execute
      Server.execute(message, options)
    end

    def message
      "#{instruction} #{arguments}".strip
    end
  end
end
