require 'spec_helper'

describe Semetric::GetRequest do
  let(:path) do
    Semetric::Path.new(id: 'fe66302b0aee49cfbd7d248403036def').basic
  end

  describe "#initialize" do
    it "raises an error for an invalid api key" do
      expect { described_class.new(path, 'invalid key') }.
        to raise_error Semetric::Errors::InvalidApiKey
    end
  end

  describe "#fetch_data" do
    let(:request) do
      described_class.new(path, '8d9bafc5dbef47e881467320e1a1e8f3')
    end
    it "gets a field from info response" do

      expect(request.fetch_data 'name').to eq "Lady Gaga"
    end

    it "raises an error when the field is incorrect" do
      expect { request.fetch_data 'whatever' }.
        to raise_error Semetric::Errors::InvalidField
    end
  end
end
