module Semetric
  class Entity < SimpleDelegator
    FIELDS = %w(modified_by name modification_date creation_date
                genre record_id).freeze

    SUMMARY_FIELDS = %w(description overview available_until
                        rank previous_rank has_data).freeze

    def data_class
      response("class")
    end

    def images
      Image.build_from_array response("images")
    end

    FIELDS.each do |field_name|
      define_method field_name do
        response(field_name)
      end
    end

    SUMMARY_FIELDS.each do |field_name|
      define_method field_name do
        response("summary").fetch(field_name)
      end
    end
  end
end
