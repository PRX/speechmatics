# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/test_helper')

# create dummy class based on the API
class TestApi < ::Speechmatics::API
end

describe Speechmatics::API do

  before {
    @speechmatics_user_id = ENV['SPEECHMATICS_USER_ID'] || 1
    @speechmatics_auth_token = ENV['SPEECHMATICS_API_KEY'] || "thisisatestkeyonly"
  }

  it "is initialized with defaults" do
    oc = TestApi.new
    oc.current_options.wont_be_nil
    oc.current_options.must_equal HashWithIndifferentAccess.new(Speechmatics.options)
  end

  it "is initialized with specific values" do
    oc = TestApi.new(auth_token: @speechmatics_auth_token, user_id: @speechmatics_user_id)
    oc.current_options.wont_be_nil
    oc.current_options.wont_equal Speechmatics.options

    oc.current_options[:auth_token].must_equal @speechmatics_auth_token
    oc.auth_token.must_equal @speechmatics_auth_token

    oc.current_options[:user_id].must_equal @speechmatics_user_id
    oc.user_id.must_equal @speechmatics_user_id
  end

end

