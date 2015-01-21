require 'spec_helper'

describe Semetric::Path do
  let(:id)   {"beatles"}
  let(:type) {"artist"}

  describe "#initialize" do
    id_with_spaces = 'id  with   spaces '
    subject { Semetric::Path.new(id: id_with_spaces) }

    it { is_expected.to have_attributes(type: 'entity', source: nil) }

    it "handles id with spaces" do
      expect(subject.id).to eq 'id+with+spaces'
    end
  end

  describe "#basic" do
    it "returns a path with a source" do
      source = "facebook"
      path   = Semetric::Path.new(type: type, source: source, id: id)

      expect(path.basic).to eq "/#{type}/#{source}:#{id}"
    end

    it "returns a path with semetric as default source" do
      path   = Semetric::Path.new(type: type,id: id)

      expect(path.basic).
        to eq "/#{type}/#{id}"
    end
  end

  describe "#with_datatype" do
    let(:path) { Semetric::Path.new(type: type,id: id) }
    let(:data_type) { 'comments' }

    it "returns a path with a subsource" do
      subsource = 'facebook'

      expect(path.with_datatype subsource, data_type).
        to eq "/#{type}/#{id}/#{data_type}/#{subsource}"
    end

    it "returns a path with total instead of a subsource" do
      expect(path.with_datatype data_type).
        to eq "/#{type}/#{id}/#{data_type}/total"
    end
  end
end
