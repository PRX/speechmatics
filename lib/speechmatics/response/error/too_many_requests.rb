# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class TooManyRequests < self
    ERROR_STATUS = 429
    def self.matches_message?(_message); true; end
  end
end
