# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class BadGateway < self
    ERROR_STATUS = 502
    def self.matches_message?(_message); true; end
  end
end
