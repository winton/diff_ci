Application.class_eval do

  post '/baseline.json' do
    key   = params[:key]
    value = params[:value]
    value = Oj.dump(value)

    redis.set(key, value)
    value
  end
end