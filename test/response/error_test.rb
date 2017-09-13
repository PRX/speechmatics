# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Speechmatics::Response::Error do
  described_class = Speechmatics::Response::Error

  describe '::classify' do
    # see error table at https://app.speechmatics.com/api-details#errorCodes

    describe '4xx errors' do
      tests = [{
        response: {status: 400, error: 'Malformed request'},
        error_class: described_class::MalformedRequest
      },{
        response: {status: 400, error: 'Missing data_file'},
        error_class: described_class::MissingDataFile
      },{
        response: {status: 400, error: 'No language selected'},
        error_class: described_class::MissingLanguage
      },{
        response: {status: 400, error: 'Missing callback'},
        error_class: described_class::MissingCallback
      },{
        response: {status: 400, error: 'Requested product not available'},
        error_class: described_class::ProductNotAvailable
      },{
        response: {status: 401, error: 'Invalid User Id or Token'},
        error_class: described_class::Unauthorized
      },{
        response: {status: 403, error: 'Job rejected due to invalid audio'},
        error_class: described_class::InvalidAudio
      },{
        response: {status: 403, error: 'Insufficient Credit'},
        error_class: described_class::InsufficientCredit
      },{
        response: {status: 404, error: 'Job not found'},
        error_class: described_class::JobNotFound
      },{
        response: {status: 404, error: 'Text could not be aligned to audio'},
        error_class: described_class::CannotAlign
      },{
        response: {status: 404, error: 'Job was rejected on submission'},
        error_class: described_class::RejectedOnSubmission
      },{
        response: {status: 404, error: 'Job is not of type alignment'},
        error_class: described_class::NotAlignmentJob
      },{
        response: {status: 404, error: 'Job In Progress'},
        error_class: described_class::JobInProgress
      },{
        response: {status: 404, error: 'Output format Not Supported'},
        error_class: described_class::UnsupportedOutputFormat
      },{
        response: {status: 429, error: 'Too Many requests'},
        error_class: described_class::TooManyRequests
      }]

      tests.each do |t|
        it "correctly classifies #{t[:response][:status]}: #{t[:response][:error]}" do
          raw_response = raw_response_stub(
            t[:response][:status],
            { 'error' => t[:response][:error] }
          )
          response = Speechmatics::Response.new(raw_response)
          err = described_class.classify(response)
          err.class.must_equal t[:error_class]
        end
      end
    end

    describe '5xx errors' do
      tests = [{
        status: 500,
        error_class: described_class::InternalServerError
      },{
        status: 502,
        error_class: described_class::BadGateway
      },{
        status: 503,
        error_class: described_class::ServiceUnavailable
      }]

      tests.each do |t|
        it "correctly classifies status #{t[:status]}" do
          raw_response = raw_response_stub(t[:status])
          response = Speechmatics::Response.new(raw_response)
          err = described_class.classify(response)
          err.class.must_equal t[:error_class]
        end
      end
    end
  end
end
