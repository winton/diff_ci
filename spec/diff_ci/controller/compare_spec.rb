require 'spec_helper'

describe "post /compare.json" do

  before :all do
    @key = "test"
    redis.del(@key)
  end

  before :all do
    @value = [ 'a', 'b', 'c' ]
    json = Oj.dump(key: @key, value: @value)
    post('/compare.json', json, { "CONTENT_TYPE" => "application/json" })
  end

  describe "response" do
    subject { last_response }
    it      { should be_ok }

    describe "body" do
      subject {
        Oj.load(last_response.body)
      }
      it do
        should eq(
          pass:       true,
          baseline:   @value,
          additions:  [],
          removals:   [],
          sequence:   true,
          difference: 0
        )
      end
    end
  end
end