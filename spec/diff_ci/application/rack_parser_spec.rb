require 'spec_helper'

describe Rack::Parser do

  before :all do
    Application.post '/parse.json' do
      "#{params.inspect}"
    end
  end

  describe "json request" do

    before :all do
      post('/parse.json', '{"a":"b","c":"d"}', { "CONTENT_TYPE" => "application/json" })
    end

    describe "response" do
      subject { last_response }
      it      { should be_ok }

      describe "body" do
        subject { last_response.body }
        it      { should eq('{"a"=>"b", "c"=>"d"}') }
      end
    end
  end
end