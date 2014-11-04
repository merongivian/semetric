require 'spec_helper'

describe Semetric::GetRequest do
  let(:id) { 'lady gaga' }

  describe "#initialize" do
    it "raises an error for an invalid api key" do
      path_generator = Semetric::Path.new(api_key: 'invalid key', id: id)
      expect { Semetric::GetRequest.new(path_generator) }.
        to raise_error Semetric::Errors::InvalidApiKey
    end
  end

  describe "#fetch" do
    let(:path_generator) do
      Semetric::Path.new(type: 'artist',
                         source: 'lastfm',
                         api_key: '8d9bafc5dbef47e881467320e1a1e8f3',
                         id: id)
    end

    let(:request) do
      Semetric::GetRequest.new(path_generator)
    end

    it "gets a field from info response" do
      expect(request.fetch 'name').to eq "Lady Gaga"
    end

    it "raises an error when no data is found" do
      expect { request.fetch 'whatever' }.
        to raise_error Semetric::Errors::InvalidField
    end
  end
end
