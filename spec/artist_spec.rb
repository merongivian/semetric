require 'spec_helper'

describe Semetric::Artist, vcr: false do
  let(:artist) { Semetric::Artist.new('ladytron') }

  describe "#initialize" do
    it "uses type:lastfm entity:artist as default values" do
      name = "ladytron"
      expect(Semetric::Path::Generator).
        to receive(:new).with(type: 'artist',
                              source: 'lastfm',
                              id: name)
      Semetric::Artist.new(name)
    end
  end

  describe "#bio" do
    it "gets the biography" do
      expect(artist.bio).to include "formed in 1999 in Liverpool"
    end
  end

  describe "#images" do
    it "gets images with url's" do
      url = artist.images.first.url
      expect(url).to include "cloudfront"
    end
  end

  describe "#fans" do
    it "returns data without any subsource" do
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
    it "returns data without any subsource" do
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
    it "returns data without any subsource" do
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
    it "returns data without any subsource" do
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
end
