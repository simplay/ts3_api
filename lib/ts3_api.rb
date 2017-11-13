require 'logger'
require 'dotenv'
Dotenv.load

logger = Logger.new(ENV['LOG_PATH'] || STDOUT)

require "ts3_api/version"
require "ts3_api/server"
require "ts3_api/connection"
require "ts3_api/decoder"
require "ts3_api/encoder"
require "ts3_api/response"
require "ts3_api/reader"

require "ts3_api/resources/client"

require "ts3_api/commands/command"
require "ts3_api/commands/client_list"
require "ts3_api/commands/client_kick"
require "ts3_api/commands/client_poke"

module TS3API
  def self.root
    File.dirname __dir__
  end

  def self.log(message, level = :info)
    logger.send(level, message)
  end

  def self.logger
    @logger ||= Logger.new(log_path)
  end

  def self.log_path
    ENV['LOG_PATH'] || STDOUT
  end
end
