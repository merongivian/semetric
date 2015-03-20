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

      def basic
        complete_id = if source.nil?
          "#{@id}"
        else
          "%s:%s" % [@source, @id]
        end

        "/#{@type}/#{complete_id}"
      end
    end
  end
end

