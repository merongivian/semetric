module Semetric
  class Artist
    API_KEY = '8d9bafc5dbef47e881467320e1a1e8f3'

    def initialize(name)
      @path_generator = Semetric::Path::Generator.new(type: 'artist',
                                                      source: 'lastfm',
                                                      id: name)
      @name = name
    end

    def bio; entity_request.overview; end
    def images; entity_request.images; end

    private

    attr_reader :path_generator

    def entity_request
      request = Semetric::GetRequest.new(path_generator.basic, API_KEY)
      Semetric::Entity.new(request)
    end
  end
end
