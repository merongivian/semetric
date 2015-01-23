module Semetric
  module Path
    class Demographic
      def initialize(source)
        @source  = source
      end

      def location(type)
        options = %w[city country]
        check_options(options, type)
        basic + "location/#{type}"
      end

      def age_gender(type)
        options = %w[age gender]
        check_options(options, type)
        basic + type
      end

      private

      attr_reader :source

      def check_options(options, type)
        unless options.include?(type)
          raise Semetric::Errors::Demographics::InvalidOption
        end
      end

      def basic
        "/demographics/#{source}/"
      end
    end
  end
end
