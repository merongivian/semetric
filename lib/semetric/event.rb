module Semetric
  class Event
    def initialize(type, name)
      @type = type
      @path_generator = Path.new(id: name)
    end

    def data
      request = GetRequest.new(path, Artist::API_KEY)
      request.response("entities")
    end

    private

    def path
      @path_generator.basic + "/#{@type}/"
    end
  end
end
