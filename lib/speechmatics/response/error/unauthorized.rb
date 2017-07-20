# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class Unauthorized < self
    ERROR_STATUS = 401
    ERROR_MESSAGE = 'Invalid User Id or Token'
  end
end
