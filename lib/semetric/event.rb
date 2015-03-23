module Semetric
  class Event
    class InvalidType < StandardError; end

    def initialize(type, name)
      raise InvalidType unless %(tv release upload).include? type
      @type = type
      @path_generator = Path.new(id: name)
    end

    def data
      request = GetRequest.new(path, Configuration.api_key)
      request.response("entities")
    end

    private

    def path
      @path_generator.basic + "/#{@type}/"
    end
  end
end
