# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class ServiceUnavailable < self
    ERROR_STATUS = 503
    def self.matches_message?(_message); true; end
  end
end
