module Semetric
  module Artist
    class Data
      def initialize(name)
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
        events_request = Semetric::Event.new(type, @name)
        events_request.data
      end

      private

      def entity_request
        Semetric::Entity.new(@name)
      end
    end
  end
end
