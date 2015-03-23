require 'spec_helper'

describe Semetric::Configuration do
  describe ".set" do
    it "sets an specific api key" do
      key = 'my key'
      described_class.set do |config|
        config.api_key = key
      end

      expect(described_class.api_key).to eq key
    end

    it "sets a default api key" do
      described_class.set do |config|
        config.api_key = nil
      end
      expect(described_class.api_key).to eq '8d9bafc5dbef47e881467320e1a1e8f3'
    end
  end
end
