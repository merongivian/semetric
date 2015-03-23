module Semetric
  class Demographics
    LOCATION_TYPES = %w(country city)

    def initialize(subsource, name)
      @subsource = subsource
      @path_generator = Path.new(id: name)
    end

    def by_country
      data("country")
    end

    def by_city
      data("city")
    end

    def by_gender
      data("gender")
    end

    def by_age
      data("age")
    end

    private

    def data(type)
      LOCATION_TYPES.include?(type) ? location_request(type) : request(type)
    end

    def location_request(type)
      path = demographic_path + "location/#{type}"
      request = Semetric::GetRequest.new(path, Configuration.api_key)
      request.response
    end

    def request(type)
      path = demographic_path + type
      request = Semetric::GetRequest.new(path, Configuration.api_key)
      request.response("data")
    end

    def demographic_path
      @path_generator.basic + "/demographics/#{@subsource}/"
    end
  end
end
