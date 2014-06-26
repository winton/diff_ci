require 'spec_helper'

describe "/pulse" do

  before  { get '/pulse' }
  specify { expect(last_response).to be_ok }
  specify { expect(last_response.body).to eq('test OK') }
end