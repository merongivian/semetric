require 'spec_helper'

describe Semetric::Data do
  let(:valid_api_key) { '8d9bafc5dbef47e881467320e1a1e8f3' }

  let(:id)     { 'ladytron' }
  let(:source) { 'lastfm' }

  describe "#initialize" do
    context "for default values" do
      subject do
        Semetric::Data.new(api_key: valid_api_key, id: id)
      end

      it { expect(subject.type).to eq 'entity' }
      it { expect(subject.source).to be_nil }
    end

    it "raises an error for an invalid api key" do
      args = { api_key: '1231231233', id: id }

      expect { Semetric::Data.new(args) }.
        to raise_error Semetric::Errors::InvalidApiKey
    end
  end

  describe "#fetch_info" do
    let(:data) do
      Semetric::Data.new(api_key: valid_api_key,
                         type: 'artist',
                         id: id,
                         source: source)
    end

    it "gets a field from info response" do
      expect(data.info 'name').to eq "Ladytron"
    end

    it "raises an error when no data is found" do
      expect { data.info 'whatever' }.
        to raise_error Semetric::Errors::InvalidField
    end
  end
end
