# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

describe Speechmatics::Client do

  let(:response) {
    {
       balance: 90, 
       cost: 0.50,
       id: 2
     }
  }

  let(:stubs) {
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post('/v1.0/user/1/jobs/?auth_token=token') { [200, {}, response.to_json] }
    end
  }

  let(:jobs) {
    Speechmatics::User::Jobs.new(
      user_id: 1,
      auth_token: 'token',
      adapter: [:test, stubs])
  }

  it "jobs can create new job" do
    u = jobs.create(data_file: File.expand_path(File.dirname(__FILE__) + '/../zero.wav'))
    u.id.must_equal 2
    u.cost.must_equal 0.50
    u.balance.must_equal 90
  end

end
