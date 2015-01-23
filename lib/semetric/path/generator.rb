module Semetric
  module Path
    class Generator
      attr_reader :id, :source, :type

      def initialize(type: 'entity', source: nil, id:)
        @type    = type
        @source  = source
        @id      = id.strip.gsub(/\s+/, "+")
      end

      def self.chart(chart_type)
        # TODO add uuids frim the page and extract to other class
        types = %w(
            fans_added_during_last_day
            fans_added_during_last_week
            fans_daily_high_flyers
            fans_total
            views_during_last_day
            views during last week
            views_high_flyers
            views_total
            new_comments_last_day
            new_comments_last_week
            comments_total
            plays_last_day
            plays_last_week
            plays_high_flyers
            plays_total
          )
        raise Semetric::Errors::InvalidChart unless types.include?(chart_type)
        "/chart/#{chart_type}"
      end

      def basic
        complete_id = if source.nil?
          "#{@id}"
        else
          "%s:%s" % [@source, @id]
        end

        "/#{@type}/#{complete_id}"
      end

      def data_type(subsource = nil, data_type)
        subsource ||= 'total'
        basic + "/#{data_type}/#{subsource}"
      end

      def event(event_type)
        basic + "/#{event_type}/"
      end

      # TODO eztract demographics logic
      #
      def location_demographics(subsource, demographic_type)
        check_demographic_options(%w[city country], demographic_type )
        demographics(subsource) + "location/#{demographic_type}"
      end

      def age_gender_demographics(subsource, demographic_type)
        check_demographic_options(%w[age gender], demographic_type)
        demographics(subsource) + demographic_type
      end

      private

      def demographics(subsource)
        basic + "/demographics/#{subsource}/"
      end

      def check_demographic_options(options, demographic_type)
        unless options.include?(demographic_type)
          raise Semetric::Errors::Demographics::InvalidOption
        end
      end
    end
  end
end

