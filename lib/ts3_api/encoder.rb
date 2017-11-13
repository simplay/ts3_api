module TS3API
  class Encoder
    attr_accessor :message

    ESCAPED_CHARACTERS = [
      { replacement: '\\\\', match: '\\' },
      { replacement: '\\/', match: '/' },
      { replacement: '\\s', match: ' ' },
      { replacement: '\\p', match: '|' },
      { replacement: '\\a', match: '\a' },
      { replacement: '\\b', match: '\b' },
      { replacement: '\\f', match: '\f' },
      { replacement: '\\n', match: '\n' },
      { replacement: '\\r', match: '\r' },
      { replacement: '\\t', match: '\t' },
      { replacement: '\\v', match: '\v' }
    ].freeze

    def initialize(message)
      @message = message
    end

    def encode
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
