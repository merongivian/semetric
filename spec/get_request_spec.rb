require 'spec_helper'

describe Semetric::GetRequest, vcr: true do
  let(:id) { 'fe66302b0aee49cfbd7d248403036def' }
  let(:path) do
    Semetric::Path.new(
      source: nil,
      type: 'entity',
      id: id
    ).basic + "/plays/total"
  end

  describe "#initialize" do
    it "raises an error for an invalid api key" do
      expect { described_class.new(path, 'invalid key') }.
        to raise_error Semetric::GetRequest::InvalidApiKey
    end

    it "raises no data found error for malformed urls" do
      path_generator = Semetric::Path.new(id: id)
      path = path_generator.basic + "/subsource with spaces/type"
      expect { described_class.new(path, Semetric::Configuration.api_key) }.
        to raise_error Semetric::GetRequest::DataNotFound
    end
  end

  describe "#response" do
    let(:request) do
      described_class.new(path, Semetric::Configuration.api_key)
    end

    it "returns data succesfully" do
      expect(request.response :data).to be_an Array
    end

    it "accepts extra arguments" do
      args = { variant: "cumulative", granularity: "week" }
      default_start_time = request.response :start_time

      expect(request.response :start_time, args).
        to_not eq default_start_time
    end

    context "for no data error" do
      let(:path_generator) do
        Semetric::Path.new(source: nil, type: 'entity', id: id)
      end
      let(:data_type) { 'fans' }

      it "raises an error for invalid subsources" do
        path = path_generator.basic + "/any/#{data_type}"
        request = described_class.new(path, Semetric::Configuration.api_key)
        expect{ request.response('anyfield') }.
          to raise_error Semetric::GetRequest::DataNotFound
      end

      it "raises an error for subsources with no data" do
        path = path_generator.basic + "/soundcloud/#{data_type}"
        request = described_class.new(path, Semetric::Configuration.api_key)
        expect{ request.response('anyfield') }.
          to raise_error Semetric::GetRequest::DataNotFound
      end
    end
  end
end
