require File.dirname(__FILE__) + '/test_helper'

class ActionLogTest < Test::Unit::TestCase
  def test_should_should_belong_to_user
    assert_nil ActionLog.new.user
  end

  def test_should_should_belong_to_loggable
    assert_nil ActionLog.new.loggable
  end
end