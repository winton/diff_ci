require 'spec_helper'

describe Application do
  include Rack::Test::Methods

  def app
    Application
  end

  it "has a pulse" do
    get '/pulse'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('test OK')
  end
end