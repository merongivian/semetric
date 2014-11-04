require 'spec_helper'

describe Semetric::Path do
  let(:api_key) { 'any key' }
  let(:id)      {"beatles"}
  let(:path_generator) { Semetric::Path.new(api_key: api_key, id: id) }
  let(:key_param) { "?token=#{api_key}" }

  describe "#initialize" do
    it { expect(path_generator.type).to eq 'entity'}
    it { expect(path_generator.source).to be_nil }

    it "handles id with spaces" do
      id_with_spaces = 'id  with   spaces '
      path_gen = Semetric::Path.new(api_key: api_key, id: id_with_spaces)

      expect(path_gen.id).to eq 'id+with+spaces'
    end
  end

  describe "#basic" do
    it "returns the shortest path for authentication checking" do
      expect(path_generator.basic).to eq "/entity/#{key_param}"
    end
  end

  describe "#for_source" do
    let(:type) {"artist"}

    it "returns a path with a source" do
      source = "facebook"
      path   = Semetric::Path.new(type: type,
                                  source: source,
                                  id: id,
                                  api_key: api_key)

      expect(path.for_source).
        to eq "/#{type}/#{source}:#{id}#{key_param}"
    end

    it "returns a path with semetric as default source" do
      path   = Semetric::Path.new(type: type,
                                  id: id,
                                  api_key: api_key)

      expect(path.for_source).
        to eq "/#{type}/#{id}#{key_param}"
    end
  end
end
