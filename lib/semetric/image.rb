module Semetric
  Image = Struct.new(:url, :klass, :size) do
    def self.build_from_array(arr)
      arr.map do |image_data|
        new(image_data["url"], image_data["class"],image_data["size"])
      end
    end
  end
end
