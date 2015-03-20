require 'spec_helper'

describe Semetric::Artist::Charts, vcr: true do
  describe ".fans" do
    it "returns fan charts for the last day" do
      top_last_day = described_class.fans('last day')
      top_three = top_last_day.first(3)
      expect(top_three).to eq ["Taylor Swift", "Ariana Grande", "Adam Levine"]
    end

    it "return fan charts for the last week" do
      top_last_week = described_class.fans('last week')
      top_three = top_last_week.first(3)
      expect(top_three).to eq ["Taylor Swift", "Justin Timberlake", "Ariana Grande"]
    end

    it "return fan charts for high flyers" do
      top_high_flyers = described_class.fans('high flyers')
      top_three = top_high_flyers.first(3)
      expect(top_three).to eq ["Caramelos de Cianuro", "Big Sean", "CNBLUE"]
    end

    it "return fan charts for total as default" do
      top_total = described_class.fans
      top_three = top_total.first(3)
      expect(top_three).to eq ["Justin Bieber", "Katy Perry", "Taylor Swift"]
    end
  end

  describe ".views" do
    it "returns views charts for the last day" do
      top_last_day = described_class.views('last day')
      top_three = top_last_day.first(3)
      expect(top_three).to eq ["Verbalicious", "Natalia Kills", "Willy Moon"]
    end

    it "return views charts for the last week" do
      top_last_week = described_class.views('last week')
      top_three = top_last_week.first(3)
      expect(top_three).to eq ["Natalia Kills", "Verbalicious", "Willy Moon"]
    end

    it "return views charts for high flyers" do
      top_high_flyers = described_class.views('high flyers')
      top_three = top_high_flyers.first(3)
      expect(top_three).to eq ["Buddy Ebsen", "Don Johnson", "Alberta Adams"]
    end

    it "return views charts for total as default" do
      top_total = described_class.views
      top_three = top_total.first(3)
      expect(top_three).to eq ["Ariana Grande", "Eminem", "Lorde"]
    end
  end

  describe ".comments" do
    it "returns comments charts for the last day" do
      top_last_day = described_class.comments('last day')
      top_three = top_last_day.first(3)
      expect(top_three).to eq ["Martin Garrix", "GTA", "Lane 8"]
    end

    it "return comments charts for the last week" do
      top_last_week = described_class.comments('last week')
      top_three = top_last_week.first(3)
      expect(top_three).to eq ["Martin Garrix", "Angel Haze", "Ellie Goulding"]
    end

    it "return comments charts for total as default" do
      top_total = described_class.comments
      top_three = top_total.first(3)
      expect(top_three).to eq ["Skrillex", "CAKED UP", "Hardwell"]
    end
  end

  describe ".plays" do
    it "returns plays charts for the last day" do
      top_last_day = described_class.plays('last day')
      top_three = top_last_day.first(3)
      expect(top_three).to eq ["Taylor Swift", "Tinashe", "Rihanna"]
    end

    it "return plays charts for the last week" do
      top_last_week = described_class.plays('last week')
      top_three = top_last_week.first(3)
      expect(top_three).to eq ["Taylor Swift", "Ellie Goulding", "Rihanna"]
    end

    it "return plays charts for high flyers" do
      top_high_flyers = described_class.plays('high flyers')
      top_three = top_high_flyers.first(3)
      expect(top_three).to eq ["Kelly Clarkson", "Banda Carnaval", "Tiziano Ferro"]
    end

    it "return plays charts for total as default" do
      top_total = described_class.plays
      top_three = top_total.first(3)
      expect(top_three).to eq ["Rihanna", "Pitbull", "Justin Bieber"]
    end
  end
end
