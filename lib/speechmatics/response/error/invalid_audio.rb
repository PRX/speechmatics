# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class InvalidAudio < self
    ERROR_STATUS = 403
    ERROR_MESSAGE = 'Job rejected due to invalid audio'
  end
end
