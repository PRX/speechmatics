# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class InsufficientCredit < self
    ERROR_STATUS = 403
    ERROR_MESSAGE = 'Insufficient Credit'
  end
end
