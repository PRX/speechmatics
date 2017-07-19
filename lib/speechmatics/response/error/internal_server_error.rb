# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class InternalServerError < self
    ERROR_STATUS = 500
    def self.matches_message?(_message); true; end
  end
end
