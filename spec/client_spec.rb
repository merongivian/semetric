require 'spec_helper'

describe Semetric::Data do
  let(:invalid_api_key) { '1231231233' }
  let(:valid_api_key)   { '8d9bafc5dbef47e881467320e1a1e8f3' }

  let(:source) { 'lastfm' }
  let(:artist) { 'ladytron' }

  describe "#fetch_data" do
    it "gets data succesfully" do
      valid_client = Semetric::Data.new(valid_api_key, artist, source)

      expect { valid_client.fetch_data }.
        to_not raise_error
    end

    it "raises an error" do
      invalid_client = Semetric::Data.new(invalid_api_key, artist, source)

      expect { invalid_client.fetch_data }.
        to raise_error StandardError, 'The api key is invalid'
    end
  end
end
