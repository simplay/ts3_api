module TS3API
  class Response
    class Status
      attr_reader :id, :msg
      def initialize(msg)
        require 'pry'; binding.pry if msg.nil?
        raw_id, raw_status = msg.strip.split(/\s/)[1..-1]
        @id = raw_id.delete('id=').to_i
        @msg = raw_status.delete('msg=')
      end

      def ok?
        msg == 'ok'
      end
    end

    attr_reader :message,
                :attributes,
                :status

    def initialize(message)
      @message = message

      split_msg = message.split("\n")
      case split_msg.count
      when 1
        @status = Status.new(split_msg.first)
        @attributes = []
      else
        response_msg, status_msg = message.split("\n")
        @status = Status.new(status_msg)
        @attributes = response_msg.split('|').map do |r|
          splits = r.split(/\s/).reject(&:empty?)
          splits.map do |split|
            key, value = split.split('=')
            v = Decoder.new(value).decode
            [key.to_sym, v || nil]
          end.to_h
        end
      end
    end

    def ok?
      status.ok?
    end
  end
end
