# -*- encoding: utf-8 -*-

require 'simplecov'
SimpleCov.command_name 'Unit Tests'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

require 'byebug'

require 'speechmatics'

def raw_response_stub(status, body = '')
  Struct.new(:status, :body).new(status, body)
end
