Application.class_eval do
  
  post '/compare.json' do
    "#{params.inspect}"
  end
end