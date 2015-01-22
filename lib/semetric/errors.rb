module Semetric
  module Errors
    class InvalidApiKey < StandardError; end
    class InvalidField < StandardError; end

    module Demographics
      class InvalidOption < StandardError; end
    end
  end
end
