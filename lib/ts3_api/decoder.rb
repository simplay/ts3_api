module TS3API
  class Decoder
    attr_accessor :message
    
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

    def initialize(message)
      @message = message
    end

    def decode
      return if message.nil?
      ESCAPED_CHARACTERS.inject(message) do |msg, rule|
        msg.gsub(
          rule[:match], 
          rule[:replacement]
        )
      end
    end
  end
end
