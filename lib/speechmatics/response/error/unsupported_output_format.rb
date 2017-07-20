# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class UnsupportedOutputFormat < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Output format Not Supported'
  end
end
