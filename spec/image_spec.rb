describe Semetric::Image do
  describe ".build_from_array" do
    let(:img1) { { url: "http://one", class: "image", size: "10" } }
    let(:img2) { { url: "http://two", class: "image", size: "20" } }

    let(:images_data){ [img1, img2] }

    it "returns multiple images from an array with response data" do
      images = [described_class.new(img2[:url], img2[:class], img2[:size]),
                described_class.new(img1[:url], img1[:class], img1[:size])]

      expect(described_class.build_from_array images_data).
        to match_array images
    end
  end
end
