# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class RejectedOnSubmission < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Job was rejected on submission'
  end
end
