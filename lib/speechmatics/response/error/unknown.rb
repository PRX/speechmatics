# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class Unknown < self
    def self.matches?(_response); false; end
  end
end
