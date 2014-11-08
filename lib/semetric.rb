require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  URL = 'http://api.semetric.com'

  class GetRequest
    def initialize(path, api_key)
      @path    = path
      @api_key = api_key
      raise Semetric::Errors::InvalidApiKey unless valid_key?
    end

    def fetch_data(field)
      data['response'].fetch(field) do
        raise Semetric::Errors::InvalidField
      end
    end

    private

    attr_reader :api_key, :path

    def valid_key?
      data["success"] || data["error"]["code"].to_i != 401
    end

    def data
      connection.
        get(@path, token: api_key).
          body
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
