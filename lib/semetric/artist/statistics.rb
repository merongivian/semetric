module Semetric
  module Artist
    class Statistics
      def initialize(type, subsource, name)
        @type = type
        @subsource = subsource
        @path_generator = Path.new(name)
      end

      def data(granularity: 'day', variant: 'diff')
        options = { granularity: granularity, variant: variant }
        request = GetRequest.new(path, Configuration.api_key)
        request.response('data', options).map(&:to_i)
      end

      private

      def path
        @path_generator.basic + "/#{@type}/#{@subsource}"
      end
    end
  end
end
