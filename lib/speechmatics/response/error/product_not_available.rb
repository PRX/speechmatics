# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class ProductNotAvailable < self
    ERROR_STATUS = 400
    ERROR_MESSAGE = 'Requested product not available'
  end
end
