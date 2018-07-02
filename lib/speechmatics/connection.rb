  # -*- encoding: utf-8 -*-

require 'faraday_middleware'

module Speechmatics
  module Connection

    ALLOWED_OPTIONS = [
      :headers,
      :url,
      :params,
      :request,
      :ssl
    ].freeze

    def merge_default_options(opts={})
      opts = opts.slice(*ALLOWED_OPTIONS)
      headers = opts.delete(:headers) || {}
      params = opts.delete(:params) || {}
      options = {
        url: endpoint,
        params: { auth_token: auth_token },
        headers: { 'User-Agent' => user_agent },
        ssl: { verify: false },
        request: { timeout: 120 }
      }.merge(opts)
      options[:headers] = options[:headers].merge(headers)
      options[:params] = options[:params].merge(params)
      options
    end

    def connection(options={})
      opts = merge_default_options(options)

      @conn ||= Faraday::Connection.new(opts) do |connection|
        connection.request  :multipart
        connection.request  :url_encoded
        connection.response :mashify
        connection.response :logger if ENV['DEBUG']
        connection.response :json, :content_type => /\bjson$/
        connection.adapter(*adapter)
      end
    end
  end
end
