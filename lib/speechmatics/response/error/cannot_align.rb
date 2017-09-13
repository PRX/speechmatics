# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class CannotAlign < self
    ERROR_STATUS = 404
    ERROR_MESSAGE = 'Text could not be aligned to audio'
  end
end
