module Semetric
  class Statistics
    def initialize(request)
      @request = request
    end

    def data(granularity: 'day', variant: 'diff')
      options = { granularity: granularity, variant: variant }
      @request.response('data', options).map(&:to_i)
    end
  end
end
