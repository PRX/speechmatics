# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/test_helper')

describe Speechmatics::Client do

  it "returns a user api object" do
    client = Speechmatics::Client.new
    client.user.wont_be_nil
  end

end
