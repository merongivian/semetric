module Semetric
  module Errors
    class InvalidApiKey < StandardError; end
    class InvalidField < StandardError; end
    class DataNotFound < StandardError; end

    class InvalidChart < StandardError; end

    module Path
      class InvalidType < StandardError; end
    end

    module Demographics
      class InvalidOption < StandardError; end
    end
  end
end
