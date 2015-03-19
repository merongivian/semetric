require 'spec_helper'

describe Semetric::Artist::Statistics, vcr: true do
  let(:statistics) { Semetric::Artist::Statistics.new("fans", "twitter", "the beatles") }

  describe "#data" do
    it "returns data with default options" do
      data = statistics.data
      expect(data.length).to eq 1867
      expect(data.first).to eq 209
    end

    it "returns data with fixed options" do
      data = statistics.data(granularity: 'week', variant: 'cumulative')
      expect(data.length).to eq 268
      expect(data.first).to eq 44689
    end
  end
end
