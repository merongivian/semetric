require 'spec_helper'

describe Semetric::Entity do
  let(:entity_request) { instance_double("Semetric::GetRequest") }
  let(:entity) { Semetric::Entity.new('some id', entity_request) }

  let(:images_data) do
    [{ url: "", class: "", size: "" }] * 2
  end
  let(:summary_data) do
    {
      description: "awesome singer",
      overview: "freddy bla bla bla",
      available_until: "23/03/2016",
      rank: 88,
      previous_rank: 140,
      has_data: true
    }
  end

  let(:fields) do
    {
      modified_by: "Peter Parker",
      name: "Freddy Mercury",
      modification_date: "02/02/2002",
      images: images_data,
      summary: summary_data,
      creation_date: "02/02/2003",
      genre: "pop",
      record_id: "12345",
      class: "artist",
      id: "any id"
    }
  end

  before do
    fields.each do |field, data|
      allow(entity_request).to receive(:response).
        with(field).and_return data
    end
  end

  context "when it retrieves data from a simple field" do
    specify { expect(entity.modified_by).      to eq fields[:modified_by] }
    specify { expect(entity.name).             to eq fields[:name] }
    specify { expect(entity.modification_date).to eq fields[:modification_date] }
    specify { expect(entity.creation_date).    to eq fields[:creation_date] }
    specify { expect(entity.genre).            to eq fields[:genre] }
    specify { expect(entity.record_id).        to eq fields[:record_id] }
    specify { expect(entity.data_class).       to eq fields[:class] }
    specify { expect(entity.modified_by).      to eq fields[:modified_by] }
  end

  context "when it retrieves data from a nested field" do
    describe "#images" do
      it "creates images array from data" do
        imgs = [Semetric::Image.new("", "", "")] * 2

        expect(entity.images).to match_array imgs
      end
    end

    describe "summary fields" do
      specify { expect(entity.description).    to eq summary_data[:description] }
      specify { expect(entity.overview).       to eq summary_data[:overview] }
      specify { expect(entity.available_until).to eq summary_data[:available_until] }
      specify { expect(entity.rank).           to eq summary_data[:rank] }
      specify { expect(entity.previous_rank).  to eq summary_data[:previous_rank] }
      specify { expect(entity.has_data).       to eq summary_data[:has_data] }
    end
  end
end
