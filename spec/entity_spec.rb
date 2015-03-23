require 'spec_helper'

describe Semetric::Entity, vcr: true do
  let(:entity) { Semetric::Entity.new('radiohead') }

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


        urls = [
          "#{cloudfront_url}/64/#{image_name}",
          "#{cloudfront_url}/126/#{image_name}",
          "#{cloudfront_url}/256/#{image_name}",
          "#{cloudfront_url}/full_size/#{image_name}"
        ]

        expect(entity.images).to match_array urls
      end
    end

    describe "summary fields" do
      specify { expect(entity.description).    to be_nil }
      specify { expect(entity.overview).       to include "band from Abingdon" }
      specify { expect(entity.available_until).to be_nil }
      specify { expect(entity.rank).           to eq 3365 }
      specify { expect(entity.previous_rank).  to eq 3821 }
      specify { expect(entity.has_data).       to be true }
    end
  end
end
