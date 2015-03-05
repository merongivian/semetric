require 'spec_helper'

describe Semetric::Entity, vcr: true do
  let(:api_key) { '8d9bafc5dbef47e881467320e1a1e8f3' }
  let(:path) do
    Semetric::Path::Generator.new(type: 'artist',
                                  source: 'lastfm',
                                  id: 'radiohead').basic
  end
  let(:entity_request) { Semetric::GetRequest.new(path, api_key) }
  let(:entity) { Semetric::Entity.new(entity_request) }


  context "when it retrieves data from a simple field" do
    specify { expect(entity.modified_by).      to be_nil }
    specify { expect(entity.name).             to eq "Radiohead" }
    specify { expect(entity.modification_date).to be_nil }
    specify { expect(entity.creation_date).    to be_nil }
    specify { expect(entity.genre).            to be_nil }
    specify { expect(entity.record_id).        to eq "111595" }
    specify { expect(entity.data_class).       to eq "artist" }
    specify { expect(entity.modified_by).      to be_nil }
  end

  context "when it retrieves data from a nested field" do
    describe "#images" do
      it "creates images array from data" do
        cloudfront_url = "//d2ols6i12gwtgn.cloudfront.net"
        image_name = "2b8242893eb1569d91ed4a5a784a2fd8.jpg"

        image_64size_url = "#{cloudfront_url}/64/#{image_name}"
        image_126size_url = "#{cloudfront_url}/126/#{image_name}"
        image_256size_url = "#{cloudfront_url}/256/#{image_name}"
        image_fullsize_url = "#{cloudfront_url}/full_size/#{image_name}"

        imgs = [
          Semetric::Image.new(image_64size_url, "image", "64"),
          Semetric::Image.new(image_126size_url, "image", "126"),
          Semetric::Image.new(image_256size_url, "image", "256"),
          Semetric::Image.new(image_fullsize_url, "image", "0"),
        ]

        expect(entity.images).to match_array imgs
      end
    end

    describe "summary fields" do
      specify { expect(entity.description).    to be_nil }
      specify { expect(entity.overview).       to include "band from Abingdon" }
      specify { expect(entity.available_until).to be_nil }
      specify { expect(entity.rank).           to eq 651 }
      specify { expect(entity.previous_rank).  to eq 675 }
      specify { expect(entity.has_data).       to be true }
    end
  end
end
