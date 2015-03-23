module Semetric
  class Entity
    FIELDS = %w(modified_by name modification_date creation_date
                genre record_id).freeze

    SUMMARY_FIELDS = %w(description overview available_until
                        rank previous_rank has_data).freeze

    def initialize(name)
      @path_generator = Path.new(id: name)
    end

    def data_class
      data.response("class")
    end

    def images
      data.response("images").map { |image_data| image_data["url"] }
    end

    FIELDS.each do |field_name|
      define_method field_name do
        data.response(field_name)
      end
    end

    SUMMARY_FIELDS.each do |field_name|
      define_method field_name do
        response = data.response("summary")
        response.fetch(field_name)
      end
    end

    private

    def data
      path = @path_generator.basic
      GetRequest.new(path, Artist::API_KEY)
    end
  end
end
