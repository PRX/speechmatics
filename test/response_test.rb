# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe Speechmatics::Response do
  describe '::parse' do
    describe 'with an error response' do
      let(:response) { raw_response_stub(422) }

      it 'raises a Speechmatics::Response::Error' do
        lambda {
          Speechmatics::Response.parse(response)
        }.must_raise Speechmatics::Response::Error
      end
    end

    describe 'with an successful response' do
      let(:response) { raw_response_stub(200, 'good stuff') }

      it 'returns a Response object' do
        res = Speechmatics::Response.parse(response)
        res.class.must_equal Speechmatics::Response
        res.body.must_equal 'good stuff'
      end
    end
  end
end
