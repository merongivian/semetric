module Semetric
  module Artist
    API_KEY = '8d9bafc5dbef47e881467320e1a1e8f3'

    class Data
      def initialize(name)
        @path_generator = Semetric::Path::Generator.new(type: 'artist',
                                                        source: 'lastfm',
                                                        id: name)
        @name = name
      end

      def bio
        entity_request.overview
      end

      def images
        entity_request.images
      end

      %w(fans plays views comments downloads).each do |statistic_field|
        define_method statistic_field do |subsource = "total", **options|
          statistics_request = Statistics.new(statistic_field, subsource, @name)
          statistics_request.data(options)
        end
      end

      def demographics(subsource, category: "country")
        demographics_request = Semetric::Demographics.new(subsource, @name)
        demographics_request.public_send("by_#{category}")
      end

      def events(type)
        event_data(type)
      end

      private

      attr_reader :path_generator

      def entity_request
        request(path_generator.basic, Semetric::Entity)
      end

      def event_data(type)
        path = path_generator.event(type)
        request(path, Semetric::Event).data
      end

      def request(path, klass)
        request = Semetric::GetRequest.new(path, API_KEY)
        klass.new(request)
      end
    end
  end
end
