module Semetric
  class Path
    attr_reader :id, :source, :type

    def initialize(type: 'entity', source: nil, id:)
      @type    = type
      @source  = source
      @id      = id.strip.gsub(/\s+/, "+")
    end

    def basic
      complete_id = source ? "#{@source}:#{@id}" : "#{@id}"
      "/#{@type}/#{complete_id}"
    end
  end
end
