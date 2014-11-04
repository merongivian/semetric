require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  URL = 'http://api.semetric.com'

  class Data
    attr_reader :type, :source

    def initialize(api_key:, type: 'entity', source: nil, id:)
      @api_key = api_key
      raise Semetric::Errors::InvalidApiKey unless valid_key?

      @type   = type
      @source = source
      @id     = id
    end

    def info(field)
      request = connection.get("/#{@type}/#{@source}:#{@id}?token=#{@api_key}")
      request.body['response'].fetch(field) do
        raise Semetric::Errors::InvalidField
      end
    end

    private

    def valid_key?
      body["success"] || body["error"]["code"].to_i != 401
    end

    def body
      request = connection.get("/entity/?token=#{@api_key}")
      request.body
    end

    def connection
      Faraday.new(url: URL) do |conn|
        conn.request  :url_encoded
        conn.response :oj
        conn.adapter  Faraday.default_adapter
      end
    end
  end
end
