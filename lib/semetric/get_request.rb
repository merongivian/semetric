
require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  URL = 'http://api.semetric.com'

  class GetRequest
    def initialize(path, api_key)
      @path        = path
      self.api_key = api_key
      #@args = { token: api_key }
    end

    def response(field, **options)
      @args.merge options unless options
      data(options)['response'].fetch(field.to_s)
    end

    def invalid_key?
      !data["success"] &&
        data["error"]["code"].to_i == 401
    end

    private

    attr_reader :api_key, :path, :args

    def api_key=(api_key)
      @api_key = api_key
      raise Semetric::Errors::InvalidApiKey if invalid_key?
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
