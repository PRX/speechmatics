# -*- encoding: utf-8 -*-

module Speechmatics
  class Response
    class Error < StandardError
      TYPES = []

      class << self
        def inherited(subclass)
          TYPES << subclass
        end

        def classify(response)
          klass = TYPES.find { |t| t.matches?(response) } || Unknown
          klass.new(response)
        end

        def matches?(response)
          matches_status?(response.raw.status) &&
            matches_message?(error_message(response))
        end

        def matches_status?(status)
          self::ERROR_STATUS == status
        end

        def matches_message?(message)
          self::ERROR_MESSAGE == message
        end

        def error_message(response)
          response['error']
        rescue
          ''
        end
      end

      attr_reader :response

      def initialize(response)
        @response = response
        super self.class.error_message(response)
      end
    end
  end
end
