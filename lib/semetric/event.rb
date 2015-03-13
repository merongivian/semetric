module Semetric
  class Event
    def initialize(request)
      @request = request
    end

    def data
      @request.response("entities")
    end
  end
end
