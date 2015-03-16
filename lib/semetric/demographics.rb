module Semetric
  class Demographics
    def initialize(subsource, name)
      @subsource = subsource
      @path_generator = Semetric::Path::Generator.new(type: 'artist',
                                                      source: 'lastfm',
                                                      id: name)
    end

    def by_country
      location_data("country")
    end

    def by_city
      location_data("city")
    end

    def by_gender
      people_category_data("gender")
    end

    def by_age
      people_category_data("age")
    end

    private

    def location_data(subtype)
      data(:location, subtype)
    end

    def people_category_data(subtype)
      data(:people_category, subtype)
    end

    def data(type, subtype)
      path = @path_generator.demographics(@subsource, subtype, type)
      request = Semetric::GetRequest.new(path, Semetric::Artist::API_KEY)

      if type == :location
        request.response
      elsif type == :people_category
        request.response("data")
      end
    end
  end
end
