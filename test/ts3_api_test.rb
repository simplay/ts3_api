require 'test_helper'

class TS3APITest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TS3API::VERSION
  end
end
