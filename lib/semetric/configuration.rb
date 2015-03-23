module Semetric
  module Configuration
    DEFAULT_API_KEY = '8d9bafc5dbef47e881467320e1a1e8f3'

    class << self
      attr_writer :api_key

      def set
        yield self
      end

      def api_key
        @api_key ||= DEFAULT_API_KEY
      end
    end
  end
end
