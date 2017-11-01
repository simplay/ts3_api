require 'simplecov'

SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'ts3_api'

require 'minitest/autorun'
require 'minitest/hooks'
require 'minitest/pride'

require 'mocha/mini_test'

Minitest::Test.include Minitest::Hooks
