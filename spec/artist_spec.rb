require 'spec_helper'

describe Semetric::Artist do
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
      image_class = artist.images.first.klass
      expect(image_class).to eq "image"
    end
  end
end
