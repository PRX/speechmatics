# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class JobInProgress < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Job In Progress'
  end
end
