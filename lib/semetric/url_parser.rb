module Semetric
  class Path
    attr_reader :id, :source, :type

    def initialize(type: 'entity', source: nil, id:, api_key:)
      @type    = type
      @api_key = api_key
      @source  = source
      @id      = id.strip.gsub(/\s+/, "+")
    end

    def basic
      "/entity/#{key_param}"
    end

    def for_source
      complete_source = source ? "#{@source}:#{@id}" : "#{@id}"
      "/#{@type}/#{complete_source}#{key_param}"
    end

    private

    def key_param
      "?token=#{@api_key}"
    end
  end
end
