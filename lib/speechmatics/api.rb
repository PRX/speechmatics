# -*- encoding: utf-8 -*-

module Speechmatics
  class API

    include Connection

    attr_reader(*Speechmatics::Configuration.keys)

    attr_accessor :current_options

    class_eval do
      Speechmatics::Configuration.keys.each do |key|
        define_method "#{key}=" do |arg|
          self.instance_variable_set("@#{key}", arg)
          self.current_options.merge!({:"#{key}" => arg})
        end
      end
    end

    def initialize(options={}, &block)
      apply_options(options)
      yield(self) if block_given?
    end

    def apply_options(options={})
      self.current_options ||= ActiveSupport::HashWithIndifferentAccess.new(Speechmatics.options)
      self.current_options = current_options.merge(args_to_options(options))
      Configuration.keys.each do |key|
        send("#{key}=", current_options[key])
      end
    end

    def request(method, path, params={}) # :nodoc:
      unless (method && [:get, :post, :put, :patch, :delete].include?(method))
        raise ArgumentError, "whoops, that isn't a valid http method: #{method}"
      end

      conn = connection((params[:options] || {}).merge(current_options))
      request_path = (conn.path_prefix + '/' + path).gsub(/\/+/, '/')

      response = conn.send(method) do |request|
        case method.to_sym
        when :get, :delete
          request.url(request_path, params)
        when :post, :put
          request.path = request_path
          request.body = params[:data]
        end
      end
      Speechmatics::Response.parse(response, {api: self, method: method, path: path, params: params})
    end

    def base_path
      parts = self.class.name.split("::").inject([]){|a, c|
        if c != 'Speechmatics'
          base = c.underscore
          a << base.tr('_','-')
          a << current_options["#{base.singularize}_id"] if current_options["#{base.singularize}_id"]
        end
        a
      }
      parts.join('/') + '/'
    end

    def list(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:get, base_path)
    end

    def get(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:get, base_path)
    end

    def create(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:post, base_path, {data: params})
    end

    def update(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:put, base_path, {data: params})
    end

    def delete(params={})
      self.current_options = current_options.merge(args_to_options(params))
      request(:delete, base_path)
    end

    def args_to_options(args)
      if args.is_a?(String) || args.is_a?(Symbol) || args.is_a?(Numeric)
        {"#{self.class.name.demodulize.downcase.singularize}_id" => args.to_s}
      elsif args.is_a?(Hash)
        args
      end
    end
  end
end
