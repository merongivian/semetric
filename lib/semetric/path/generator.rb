require_relative 'demographic'

module Semetric
  module Path
    class Generator
      TYPES = %w(entity        athlete       book          bookauthor
                 bookgroup     brand         celebrity     artist
                 festival      festivalgroup film          filmactor
                 filmcharacter filmcompany   filmdirector  game
                 gamedeveloper gamegroup     gamepublisher gameseries
                 league        publisher     recordlabel   team
                 tvactor       tvcharacter   tvprogram     venue
                )

      attr_reader :id, :source, :type

      def initialize(type: 'entity', source: nil, id:)
        raise Semetric::Errors::Path::InvalidType unless TYPES.include?(type)

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

      def demographics(subsource, demographic_type, tipi)
        dem_path = Demographic.new(subsource)
        basic + dem_path.send(tipi, demographic_type)
      end
    end
  end
end

