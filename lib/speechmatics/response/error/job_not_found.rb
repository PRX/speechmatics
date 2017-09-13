# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class JobNotFound < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Job not found'
  end
end
