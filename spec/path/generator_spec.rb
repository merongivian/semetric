require 'spec_helper'

describe Semetric::Path::Generator do
  let(:id)   {"beatles"}
  let(:type) {"artist"}

  describe ".chart" do
    let(:chart_type) { "fans_added_during_last_day" }

    it "returns a path for a chart" do
      expect(described_class.chart chart_type).
        to eq "/chart/#{chart_type}"
    end

    it "raises an error for an invalid chart" do
      expect{ described_class.chart "invalid type" }.
        to raise_error Semetric::Errors::InvalidChart
    end
  end

  describe ".sentiment" do
    it "returns a path for a sentiment" do
      expect(described_class.sentiment).
        to eq "/sentiment"
    end
  end

  describe "#initialize" do
    id_with_spaces = 'id  with   spaces '
    subject { described_class.new(id: id_with_spaces) }

    it { is_expected.to have_attributes(type: 'entity', source: nil) }

    it "handles id with spaces" do
      expect(subject.id).to eq 'id+with+spaces'
    end

    it "raises an error for invalid types" do
      expect{ described_class.new(id: id, type: "wrong type") }.
        to raise_error Semetric::Errors::Path::InvalidType
    end
  end

  describe "#basic" do
    it "returns a path with a source" do
      source = "facebook"
      path   = described_class.new(type: type, source: source, id: id)

      expect(path.basic).to eq "/#{type}/#{source}:#{id}"
    end

    it "returns a path with semetric as default source" do
      path   = described_class.new(type: type,id: id)

      expect(path.basic).
        to eq "/#{type}/#{id}"
    end
  end

  describe "#with_datatype" do
    let(:path) { described_class.new(type: type,id: id) }
    let(:data_type) { 'comments' }

    it "returns a path with a subsource" do
      subsource = 'facebook'

      expect(path.data_type subsource, data_type).
        to eq "/#{type}/#{id}/#{data_type}/#{subsource}"
    end

    it "returns a path with total instead of a subsource" do
      expect(path.data_type data_type).
        to eq "/#{type}/#{id}/#{data_type}/total"
    end
  end

  describe "#event" do
    let(:path)  { described_class.new(type: type,id: id) }
    let(:event_type) { 'tv' }

    it "returns a path for events" do
      expect(path.event event_type).
        to eq "/#{type}/#{id}/#{event_type}/"
    end
  end
end
