Application.class_eval do
  
  post '/compare.json' do
    key   = params[:key]
    tests = params[:tests] || {}
    value = params[:value]

    pass         = true
    baseline     = redis.get(key)
    additions    = []
    subtractions = []
    difference   = 0

    if baseline
      baseline = Oj.load(baseline)

      if value.is_a?(Array) && baseline.is_a?(Array)
        additions    = value - baseline
        subtractions = baseline - value
      end

      if value.is_a?(Numeric) && baseline.is_a?(Numeric)
        difference = value - baseline
      end

      pass = !(tests[:additions]    && additions.any?)
      pass = !(tests[:subtractions] && subtractions.any?) if pass
      pass = !(tests[:greater_than] && value > tests[:greater_than] * baseline) if pass
      pass = !(tests[:less_than]    && value < tests[:less_than]    * baseline) if pass
    else
      baseline = value
      redis.set(key, Oj.dump(baseline))
    end

    Oj.dump(
      pass:         pass,
      baseline:     baseline,
      additions:    additions,
      subtractions: subtractions,
      difference:   difference
    )
  end
end