require 'spec_helper'

describe "post /baseline.json" do

  def compare(obj)
    post(
      '/baseline.json',
      Oj.dump(obj),
      "CONTENT_TYPE" => "application/json"
    )
  end

  before do
    @key = "test"
  end

  before { redis.del(@key) }

  describe "baseline stored" do

    before do
      @value = 1
      compare(key: @key, value: @value)
    end

    describe "response" do
      subject { last_response }
      it      { should be_ok }

      describe "body" do
        subject { Oj.load(last_response.body) }
        it      { should eq(@value) }
      end
    end

    describe "redis" do

      subject { Oj.load(redis.get(@key)) }
      it      { should eq(@value) }
    end
  end
end