module Semetric
  class Path
    attr_reader :id, :source, :type

    def initialize(type: 'entity', source: nil, id:)
      @type    = type
      @source  = source
      @id      = id.strip.gsub(/\s+/, "+")
    end

    def basic
      complete_id = if source.nil?
        "#{@id}"
      else
        "%s:%s" % [@source, @id]
      end

      "/#{@type}/#{complete_id}"
    end

    def data_type(subsource = nil, data_type)
      subsource ||= 'total'
      basic + "/#{data_type}/#{subsource}"
    end

    def event(event_type)
      basic + "/#{event_type}/"
    end

    def location_demographics(subsource, demographic_type)
      check_demographic_options(%w[city country], demographic_type )
      demographics(subsource) + "location/#{demographic_type}"
    end

    def age_gender_demographics(subsource, demographic_type)
      check_demographic_options(%w[age gender], demographic_type)
      demographics(subsource) + demographic_type
    end

    private

    def demographics(subsource)
      basic + "/demographics/#{subsource}/"
    end

    def check_demographic_options(options, demographic_type)
      unless options.include?(demographic_type)
        raise Semetric::Errors::Demographics::InvalidOption
      end
    end
  end
end
