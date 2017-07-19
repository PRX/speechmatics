# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class NotAlignmentJob < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Job is not of type alignment'
  end
end
