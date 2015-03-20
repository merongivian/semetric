module Semetric
  module Artist
    class Statistics
      def initialize(type, subsource, name)
        @type = type
        @subsource = subsource
        @path_generator = Path.new(type: 'artist',
                                              source: 'lastfm',
                                              id: name)
      end

      def data(granularity: 'day', variant: 'diff')
        options = { granularity: granularity, variant: variant }
        request = GetRequest.new(path, Artist::API_KEY)
        request.response('data', options).map(&:to_i)
      end

      private

      def path
        @path_generator.basic + "/#{@type}/#{@subsource}"
      end
    end
  end
end
