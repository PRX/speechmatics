# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe Speechmatics::Client do

  let(:response) {
    {
      user: {
         balance: 90, 
         email: "demo@speechmatics.com", 
         id: 1
       }
    }
  }

  let(:stubs) {
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/v1.0/user/1/?auth_token=token') { [200, {}, response.to_json] }
    end
  }

  let(:user) {
    Speechmatics::User.new(
      user_id: 1,
      auth_token: 'token',
      adapter: [:test, stubs])
  }

  it "user can request profile" do
    u = user.get
    u.balance.must_equal 90
    u.email.must_equal "demo@speechmatics.com"
    u.id.must_equal 1
  end

end
