require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  URL = 'http://api.semetric.com'

  class GetRequest
    def initialize(path, api_key)
      @path        = path
      self.api_key = api_key
    end

    def response(field, **options)
      raise Semetric::Errors::DataNotFound if no_data_found?
      result = data(options)['response']
      result.fetch(field.to_s)
    end

    def invalid_key?
      !data["success"] &&
        data["error"]["code"].to_i == 401
    end

    private

    attr_reader :api_key, :path

    def api_key=(api_key)
      @api_key = api_key
      raise Semetric::Errors::InvalidApiKey if invalid_key?
    end

    def no_data_found?
      !data["success"] && has_data_error_code?
    end

    def has_data_error_code?
      error_code = data["error"]["code"].to_i
      error_code == 204 || error_code == 404
    end

    def data(**options)
      args = {token: api_key}.merge options

      connection.
        get(@path, args).
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
