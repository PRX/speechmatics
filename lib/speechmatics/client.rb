# -*- encoding: utf-8 -*-

module Speechmatics
  class Client < API

    def user(params={}, &block)
      @user ||= ApiFactory.api('Speechmatics::User', self, params, &block)
    end

  end
end
