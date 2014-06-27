require 'spec_helper'

describe "post /compare.json" do

  def compare(obj)
    post(
      '/compare.json', Oj.dump(obj), { "CONTENT_TYPE" => "application/json" }
    )
  end

  before do
    @key      = "test"
    @response = {
      pass:         true,
      additions:    [],
      subtractions: [],
      difference:   0
    }
  end

  before { redis.del(@key) }

  describe "baseline not stored" do

    before do
      @value = 1
      @response.merge!(baseline: @value)
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
      it      { should eq(@value) }
    end
  end

  describe "baseline stored" do
    describe "array value" do

      before do
        @value = [ 'a', 'b', 'c' ]
        @response.merge!(baseline: @value)
        redis.set(@key, Oj.dump(@value))
      end

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

      describe "item removed from array value" do

        before do
          compare(
            key:   @key,
            tests: { subtractions: true },
            value: [ 'a', 'c' ]
          )
        end

        describe "response" do
          subject { last_response }
          it      { should be_ok }

          describe "body" do
            subject { Oj.load(last_response.body) }
            it do
              should eq(@response.merge(subtractions: [ "b" ], pass: false))
            end
          end
        end
      end
    end

    describe "number value" do
      describe "greater than multiplier" do

        before do
          @value = 1
          redis.set(@key, Oj.dump(@value))
        end

        describe "fail" do

          before do
            compare(
              key:   @key,
              tests: { greater_than: 2 },
              value: 2.1
            )
          end

          describe "response" do
            subject { last_response }
            it      { should be_ok }

            describe "body" do
              subject { Oj.load(last_response.body) }
              it do
                should eq(@response.merge(baseline: @value, difference: 1.1, pass: false))
              end
            end
          end
        end

        describe "pass" do
          before do
            compare(
              key:   @key,
              tests: { greater_than: 2 },
              value: 2
            )
          end

          describe "response" do
            subject { last_response }
            it      { should be_ok }

            describe "body" do
              subject { Oj.load(last_response.body) }
              it do
                should eq(@response.merge(baseline: @value, difference: 1))
              end
            end
          end
        end
      end
    end
  end
end