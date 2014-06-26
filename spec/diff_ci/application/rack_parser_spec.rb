require 'spec_helper'

describe Rack::Parser do

  before :all do
    Application.post '/parse.json' do
      "#{params.inspect}"
    end
  end

  before  { post('/parse.json', '{"a":"b","c":"d"}', { "CONTENT_TYPE" => "application/json" }) }
  specify { expect(last_response).to be_ok }
  specify { expect(last_response.body).to eq('{"a"=>"b", "c"=>"d"}') }
end