module TS3API
  class Response
    attr_reader :message,
                :attributes

    def initialize(message)
      @message = message
      splits = message.split(/\s/).reject(&:empty?)
      @attributes = splits.map do |split|
        key, value = split.split('=')
        [key.to_sym, value || nil]
      end.to_h
    end

    def status
      attributes[:msg]
    end

    def ok?
      status == "ok"
    end
  end
end
