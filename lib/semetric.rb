require 'faraday'
require 'faraday_middleware/parse_oj'

module Semetric
  class Data
    URL = 'http://api.semetric.com'

    def initialize(api_key, artist, source)
      @api_key = api_key
      @artist  = artist
      @source  = source
    end

    def fetch_data
      get_response = connection.get(
        "/entity/"\
        "#{@source}"\
        ":#{@artist}"\
        "?token=#{@api_key}"
      )

      successfull = get_response.body.fetch("success")

      raise StandardError, 'The api key is invalid' unless successfull
    end

    private

    def connection
      Faraday.new(url: URL) do |connection|
        connection.request  :url_encoded
        connection.response :oj
        connection.adapter  Faraday.default_adapter
      end
    end
  end
end
