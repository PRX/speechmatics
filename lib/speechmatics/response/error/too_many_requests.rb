# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class TooManyRequests < self
    ERROR_STATUS = 429
    ERROR_MESSAGE = 'Too Many requests'
  end
end
