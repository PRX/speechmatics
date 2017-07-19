# -*- encoding: utf-8 -*-

class Speechmatics::Response::Error
  class MissingLanguage < self
    ERROR_STATUS = 400
    ERROR_MESSAGE = 'No language selected'
  end
end
