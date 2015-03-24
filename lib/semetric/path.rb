module Semetric
  class Path
    attr_reader :id, :source, :type

    def initialize(id, type: 'artist', source: 'lastfm')
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

