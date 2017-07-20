# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class MissingCallback < self
    ERROR_STATUS = 400
    ERROR_MESSAGE = 'Missing callback'
  end
end
