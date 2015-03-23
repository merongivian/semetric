require 'spec_helper'

describe Semetric::Artist::Data, vcr: false do
  let(:artist) { described_class.new('ladytron') }

  describe "#bio" do
    it "gets the biography" do
      expect(artist.bio).to include "formed in 1999 in Liverpool"
    end
  end

  describe "#images" do
    it "gets images with url's" do
      urls = artist.images
      expect(urls).to all(include "cloudfront")
    end
  end

  describe "#fans" do
    it "returns data with a default subsource" do
      expect(artist.fans.first).to be_an Integer
    end

    it "returns data for a subsource" do
      fans_with_subsource = artist.fans('facebook').first
      expect(fans_with_subsource).to be_an Integer
    end

    it "returns data with options" do
      fans_with_granularity = artist.fans('facebook', granularity: 'week').first
      expect(fans_with_granularity).to be_an Integer
    end
  end

  describe "#plays" do
    it "returns data with a default subsource" do
      expect(artist.plays.first).to be_an Integer
    end

    it "returns data for a subsource" do
      plays_with_subsource = artist.plays('vevo').first
      expect(plays_with_subsource).to be_an Integer
    end

    it "returns data with options" do
      plays_with_granularity = artist.plays('vevo', granularity: 'week').first
      expect(plays_with_granularity).to be_an Integer
    end
  end

  describe "#views" do
    it "returns data with a default subsource" do
      expect(artist.views.first).to be_an Integer
    end

    it "returns data for a subsource" do
      plays_with_subsource = artist.views('wikipedia').first
      expect(plays_with_subsource).to be_an Integer
    end

    it "returns data with options" do
      plays_with_granularity = artist.views('wikipedia', granularity: 'week').first
      expect(plays_with_granularity).to be_an Integer
    end
  end

  describe "#downloads" do
    it "returns data with a default subsource" do
      expect(artist.downloads.first).to be_an Integer
    end

    it "returns data for a subsource" do
      downloads_with_subsource = artist.downloads('bittorrent').first
      expect(downloads_with_subsource).to be_an Integer
    end

    it "returns data with options" do
      downloads_with_granularity = artist.downloads('bittorrent', granularity: 'week').first
      expect(downloads_with_granularity).to be_an Integer
    end
  end

  describe "#events" do
    it "returns data as for a type of event" do
      event = artist.events('release').first
      expect(event["class"]).to eq "album"
    end
  end

  describe "#demographics" do
    it "returns data for a subsource and divided by country as default " do
      demographic = artist.demographics('twitter').first
      expect(demographic).to have_key "country"
    end

    it "returns data divided by age" do
      demographic = artist.demographics('twitter', category: "age").first
      expect(demographic["age"]).to eq "00-16"
    end
  end
end
