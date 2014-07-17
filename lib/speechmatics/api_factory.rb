# -*- encoding: utf-8 -*-

module Speechmatics
  class ApiFactory

    def self.api(name, parent, options={}, &block)
      api = name.constantize.new(parent.current_options)
      api.apply_options(options)
      yield(api) if block_given?
      api
    end
  end
end
