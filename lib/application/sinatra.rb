Application.class_eval do
  
  configure do
    set :dump_errors, true
    set :root, File.expand_path("#{File.dirname(__FILE__)}/../../")
    set :public_dir, "#{root}/public"
    set :logging, true
    set :views, "#{root}/lib/#{app_name}/view"

    if ENV['RACK_ENV'] == 'test'
      set :raise_errors, true
    end
  end
end