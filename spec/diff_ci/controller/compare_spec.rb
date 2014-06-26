require 'spec_helper'

describe "post /compare.json" do

  def compare(obj)
    post(
      '/compare.json', Oj.dump(obj), { "CONTENT_TYPE" => "application/json" }
    )
  end

  before do
    @key   = "test"
    @value = [ 'a', 'b', 'c' ]
    @response = {
      pass:       true,
      baseline:   @value,
      additions:  [],
      removals:   [],
      sequence:   true,
      difference: 0
    }
  end

  before { redis.del(@key) }

  describe "baseline not stored" do

    before do
      compare(key: @key, value: @value)
    end

    describe "response" do
      subject { last_response }
      it      { should be_ok }

      describe "body" do
        subject { Oj.load(last_response.body) }
        it      { should eq(@response) }
      end
    end

    describe "redis" do

      subject { Oj.load(redis.get(@key)) }
      it      { should eq([ 'a', 'b', 'c' ]) }
    end
  end

  describe "baseline stored" do

    before { redis.set(@key, Oj.dump(@value)) }

    describe "item added to array value" do

      before do
        compare(
          key:   @key,
          tests: { additions: true },
          value: [ 'a', 'b', 'c', 'd' ]
        )
      end

      describe "response" do
        subject { last_response }
        it      { should be_ok }

        describe "body" do
          subject { Oj.load(last_response.body) }
          it do
            should eq(@response.merge(additions: [ "d" ], pass: false))
          end
        end
      end
    end
  end
end