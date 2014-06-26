require 'spec_helper'

describe "get /pulse" do

  before :all do
    get '/pulse'
  end

  describe "response" do
    subject { last_response }
    it      { should be_ok }

    describe "body" do
      subject { last_response.body }
      it      { should eq('test OK') }
    end
  end
end