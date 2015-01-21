module Semetric
  class Path
    attr_reader :id, :source, :type

    def initialize(type: 'entity', source: nil, id:)
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

    def with_datatype(subsource = nil, data_type)
      subsource ||= 'total'
      basic + "/#{data_type}/#{subsource}"
    end
  end
end
