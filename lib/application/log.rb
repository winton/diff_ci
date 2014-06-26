Application.class_eval do

  unless File.basename($0) == 'rspec' || ENV['RACK_ENV'] == 'test'
    log = File.new("#{root}/log/#{environment}.log", "a")
    STDOUT.reopen(log)
    STDERR.reopen(log)
  end
end