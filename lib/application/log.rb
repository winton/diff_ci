Application.class_eval do

  configure do
    enable :logging
    log = File.new("#{root}/log/#{environment}.log", "a+")
    log.sync = true
    use Rack::CommonLogger, log
  end
end