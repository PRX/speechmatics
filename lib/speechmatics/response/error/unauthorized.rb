# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class Unauthorized < self
    ERROR_STATUS = 401
    def self.matches_message?(_message); true; end
  end
end
