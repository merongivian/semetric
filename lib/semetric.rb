require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  URL = 'http://api.semetric.com'

  class GetRequest
    def initialize(path_generator)
      @path_generator = path_generator
      raise Semetric::Errors::InvalidApiKey unless valid_key?
    end

    def fetch(field)
      source_path = @path_generator.for_source and
        body = request_body(source_path)

      body['response'].fetch(field) do
        raise Semetric::Errors::InvalidField
      end
    end

    def request_body(path)
      connection.get(path).body
    end

    private

    def valid_key?
      body = request_body(@path_generator.basic)
      body["success"] || body["error"]["code"].to_i != 401
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
