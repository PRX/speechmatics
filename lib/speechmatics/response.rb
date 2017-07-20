# -*- encoding: utf-8 -*-

module Speechmatics
  class Response

    def self.parse(response, request={})
      new(response, request).tap do |res|
        res.check_for_error
      end
    end

    attr_accessor :raw, :request

    def initialize(response, request={})
      @raw     = response
      @request = request
    end

    def check_for_error
      raise Error.classify(self) if raw.status >= 400
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
      if self.object.is_a?(Array) || self.object.is_a?(Hash)
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
