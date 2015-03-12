module Semetric
  class Artist
    API_KEY = '8d9bafc5dbef47e881467320e1a1e8f3'

    def initialize(name)
      @path_generator = Semetric::Path::Generator.new(type: 'artist',
                                                      source: 'lastfm',
                                                      id: name)
    end

    def bio
      entity_request.overview
    end

    def images
      entity_request.images
    end

    def fans(subsource = nil, **options)
      statistics_data(subsource, "fans", options)
    end

    def plays(subsource = nil, **options)
      statistics_data(subsource, "plays", options)
    end

    def views(subsource = nil, **options)
      statistics_data(subsource, "views", options)
    end

    def comments(subsource = nil, **options)
      statistics_data(subsource, "comments", options)
    end

    def downloads(subsource = nil, **options)
      statistics_data(subsource, "downloads", options)
    end

    private

    attr_reader :path_generator

    def entity_request
      request(path_generator.basic, Semetric::Entity)
    end

    def statistics_data(subsource, datatype, options)
      path = path_generator.data_type(subsource, datatype)
      statistics_request = request(path, Semetric::Statistics)
      statistics_request.data(options)
    end

    def request(path, klass)
      request = Semetric::GetRequest.new(path, API_KEY)
      klass.new(request)
    end
  end
end
