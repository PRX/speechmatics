# -*- encoding: utf-8 -*-

module Speechmatics
  module Configuration

    VALID_OPTIONS_KEYS = [
      :user_id,
      :auth_token,
      :adapter,
      :endpoint,
      :user_agent
    ].freeze

    # Adapters are whatever Faraday supports - I like excon alot, so I'm defaulting it
    DEFAULT_ADAPTER = :excon

    # The api endpoint to get REST
    DEFAULT_ENDPOINT = 'http://api.speechmatics.com/v1.0/'.freeze

    # The value sent in the http header for 'User-Agent' if none is set
    DEFAULT_USER_AGENT = "Speechmatics Ruby Gem #{Speechmatics::VERSION}".freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow for global setting of configuration options
    def configure
      yield self
    end

    def self.extended(base)
      base.reset!
    end

    class << self
      def keys
        VALID_OPTIONS_KEYS
      end
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    # Reset configuration options to their defaults
    def reset!
      self.user_id      = nil
      self.auth_token      = nil
      self.adapter      = DEFAULT_ADAPTER
      self.endpoint     = DEFAULT_ENDPOINT
      self.user_agent   = DEFAULT_USER_AGENT
      self
    end

  end
end
