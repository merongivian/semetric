module Semetric
  class Entity
    def initialize(id, entity_request)
      @id = id
      @entity_request = entity_request
    end

    def modified_by;       get('modified_by');end
    def name;              get('name');end
    def modification_date; get('modification_date');end
    def creation_date;     get('creation_date');end
    def genre;             get('genre');end
    def record_id;         get('record_id');end
    def summary;           get('summary');end
    def data_class;        get('class');end

    def images
      Semetric::Image.build_from_array get('images')
    end

    def description;     get('summary')[:description]; end
    def overview;        get('summary')[:overview]; end
    def available_until; get('summary')[:available_until]; end
    def rank;            get('summary')[:rank]; end
    def previous_rank;   get('summary')[:previous_rank]; end
    def has_data;        get('summary')[:has_data]; end

    private

    attr_reader :id, :entity_request

    def get(field)
      entity_request.fetch_data field
    end
  end
end
