# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class MissingDataFile < self
    ERROR_STATUS = 400
    ERROR_MESSAGE = 'Missing data_file'
  end
end
