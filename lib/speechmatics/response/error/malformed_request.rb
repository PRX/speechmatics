# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class MalformedRequest < self
    ERROR_STATUS = 400
    ERROR_MESSAGE = 'Malformed request'
  end
end
