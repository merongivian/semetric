require "spec_helper"

describe Semetric::Demographics, vcr: true do
  let(:demographics) { Semetric::Demographics.new("twitter", "ladytron") }

  describe "#by_country" do
    it "return demographics divided by country" do
      country_demographics = demographics.by_country.first
      code = country_demographics["country"]["code"]
      expect(code).to eq "US"
    end
  end

  describe "#by_city" do
    it "return demographics divided by city" do
      city_demographics = demographics.by_city.first
      latitude = city_demographics["city"]["latitude"]
      expect(latitude).to eq "19.428470611572266"
    end
  end

  describe "#by_gender" do
    it "return demographics divided by gender" do
      gender_demographics = demographics.by_gender.first
      count = gender_demographics["count"]
      expect(count).to eq 209
    end
  end

  describe "#by_age" do
    it "return demographics divided by age" do
      age_demographics = demographics.by_age.first
      percent = age_demographics["percent"]
      expect(percent).to eq 0.01007194
    end
  end
end
