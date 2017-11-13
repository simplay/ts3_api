module TS3API
  class Ban
    def self.all
      response = BanList.new.execute
      response.attributes.map do |ban_attributes|
        new(ban_attributes)
      end
    end

    attr_reader :id,
                :ip,
                :name,
                :uid,
                :last_nickname,
                :created_on,
                :duration,
                :invoker_name,
                :invokeruid,
                :reason

    def initialize(attributes)
      @id            = attributes[:banid]
      @ip            = attributes[:ip]
      @name          = attributes[:name]
      @uid           = attributes[:uid]
      @last_nickname = attributes[:last_nickname]
      @created_on    = attributes[:created]
      @duration      = attributes[:duration]
      @invoker_name  = attributes[:invokername]
      @invoker_uid   = attributes[:invokeruid]
      @reason        = attributes[:reason]
    end
  end
end
