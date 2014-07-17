# -*- encoding: utf-8 -*-

module Speechmatics
  class User < API
    include Configuration

    def jobs(params={}, &block)
      @jobs ||= ApiFactory.api('Speechmatics::User::Jobs', self, params, &block)
    end

  end
end
