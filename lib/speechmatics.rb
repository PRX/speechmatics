# -*- encoding: utf-8 -*-

require 'rubygems'
require 'active_support/all'

require "speechmatics/version"
require 'speechmatics/configuration'
require 'speechmatics/connection'
require 'speechmatics/response'
require 'speechmatics/api'
require 'speechmatics/api_factory'
require 'speechmatics/client'
require 'speechmatics/user'
require 'speechmatics/user/jobs'

module Speechmatics
  extend Configuration
end
