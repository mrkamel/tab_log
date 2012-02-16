require 'test/unit'

RAILS_ROOT = File.expand_path("../../", __FILE__)

require "rubygems"
require File.expand_path("../../lib/tab_log", __FILE__)
require "active_support/test_case"

class TestLog < TabLog
  def fields
    return [:test_field]
  end 

  attr_reader :callbacks

  def before_save
    @callbacks ||= []
    @callbacks.push :before_save
  end

  def after_save
    @callbacks ||= []
    @callbacks.push :after_save
  end
end

class TabLogTest < ActiveSupport::TestCase
  def test_count
    assert_difference("TestLog.count") do
      test_log = TestLog.new(:test_field => "test_field")
      test_log.save
    end
  end

  def test_new_record?
    assert_equal true, TestLog.new.new_record?
  end

  def test_last
    test_log = TestLog.new(:test_field => "test_field")
    test_log.save

    assert_equal "test_field\n", TestLog.last
  end

  def test_size
    # already tested
  end

  def test_initialize
    # already tested
  end

  def test_save
    # already tested
  end

  def test_method_missing
    test_log = TestLog.new
    test_log.test_field = "test_field"
    test_log.save

    assert_equal "test_field\n", TestLog.last
  end

  def test_index
    test_log = TestLog.new
  end

  def test_default_values
    assert_equal [], TestLog.new.default_values
  end

  def test_fields
    assert_equal [:test_field], TestLog.new.fields
  end

  def test_path
    assert TestLog.path =~ /\A.*\/log\/test_logs.log\Z/
  end

  def test_before_save_and_after_save
    test_log = TestLog.new(:test_field => "test_field")
    test_log.save

    assert_equal [:before_save, :after_save], test_log.callbacks
  end

  def test_id
    # can't be tested
  end

  def test_escape_value
  end
end

