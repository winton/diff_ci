Application.class_eval do
  
  post '/compare.json' do
    key   = params[:key]
    tests = params[:tests] || {}
    value = params[:value]

    pass       = true
    baseline   = redis.get(key)
    additions  = []
    removals   = []
    sequence   = true
    difference = 0

    if baseline
      baseline  = Oj.load(baseline)

      if value.is_a?(Array) && baseline.is_a?(Array)
        additions = value - baseline
      end

      if tests[:additions] && additions.any?
        pass = false
      end
    else
      baseline = value
      redis.set(key, Oj.dump(baseline))
    end

    Oj.dump(
      pass:       pass,
      baseline:   baseline,
      additions:  additions,
      removals:   removals,
      sequence:   sequence,
      difference: difference
    )
  end
end