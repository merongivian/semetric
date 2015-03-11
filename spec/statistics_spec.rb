require 'spec_helper'

describe Semetric::Statistics, vcr: true do
  let(:api_key) { '8d9bafc5dbef47e881467320e1a1e8f3' }
  let(:path_generator) do
    Semetric::Path::Generator.new(type: 'artist',
                                  source: 'lastfm',
                                  id: 'the beatles')
  end
  let(:path) { path_generator.data_type('fans') }
  let(:request) { Semetric::GetRequest.new(path, api_key) }
  let(:statistics) { Semetric::Statistics.new(request)}

  describe "#start_time" do
    xit "returns start time in Date Format" do
    end
  end

  describe "#end_time" do
    xit "returns end time in Date Format" do
    end
  end

  describe "#data" do
    it "returns data without options" do
      data = statistics.data
      expect(data.length).to eq 1855
      expect(data.first).to eq 2328
    end

    it "returns data with a granularity" do
      data = statistics.data(granularity: 'week')
      expect(data.length).to eq 265
      expect(data.first).to eq 9270
    end

    it "returns data with a variant" do
      data = statistics.data(variant: 'cumulative')
      expect(data.length).to eq 1856
      expect(data.first).to eq 2050690
    end
  end
end
