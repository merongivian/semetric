module Semetric
  class Entity
    FIELDS = %w(modified_by name modification_date creation_date
                genre record_id).freeze
    SUMMARY_FIELDS = %w(description overview available_until
                        rank previous_rank has_data).freeze

    def initialize(id, entity_request)
      @id = id
      @entity_request = entity_request
    end

    def data_class
      get("class")
    end

    def images
      Image.build_from_array get("images")
    end

    FIELDS.each do |field_name|
      define_method field_name do
        get(field_name)
      end
    end

    SUMMARY_FIELDS.each do |field_name|
      define_method field_name do
        summary.fetch(field_name)
      end
    end

    private

    attr_reader :entity_request

    def summary
      get("summary")
    end

    def get(field)
      entity_request.response field
    end
  end
end
