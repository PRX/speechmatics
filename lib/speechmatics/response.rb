# -*- encoding: utf-8 -*-

module Speechmatics
  class Response
    attr_accessor :raw, :request

    def initialize(response, request={})
      @raw     = response
      @request = request

      check_for_error(response)
    end

    def check_for_error(response)
      status_code_type = response.status.to_s[0]
      case status_code_type
      when "2"
        # puts "all is well, status: #{response.status}"
      when "4", "5"
        raise "Whoops, error back from Speechmatics: #{response.status}"
      else
        raise "Unrecongized status code: #{response.status}"
      end
    end

    def body
      self.raw.body
    end

    def object_name
      self.request[:api].class.name.split("::").last.underscore
    end

    def object
      body[object_name].nil? ? body : body[object_name]
    end

    def objects
      Array(self.object)
    end

    def [](key)
      if self.object.is_a?(Array)
        self.object[key]
      else
        self.object.send(:"#{key}")
      end
    end

    def has_key?(key)
      self.object.is_a?(Hash) && self.object.has_key?(key)
    end

    # Coerce any method calls for body attributes
    #
    def method_missing(method_name, *args, &block)
      if self.has_key?(method_name.to_s)
        self.[](method_name, &block)
      elsif self.body.respond_to?(method_name)
        self.body.send(method_name, *args, &block)
      elsif self.request[:api].respond_to?(method_name)
        self.request[:api].send(method_name, *args, &block)
      else
        super
      end
    end

  end
end
