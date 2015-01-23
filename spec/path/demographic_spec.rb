require 'spec_helper'

describe Semetric::Path::Demographic do
  let(:demographic_path) { described_class.new 'facebook' }

  describe "#location" do
    it "accepts only valid options" do
      expect{ demographic_path.location "country" }.
        to_not raise_error
    end

    it "raises an error for an invalid option" do
      expect{ demographic_path.location "any location" }.
        to raise_error Semetric::Errors::Demographics::InvalidOption
    end
  end

  describe "#age_gender" do
    it "accepts only valid options" do
      expect{ demographic_path.age_gender "gender" }.
        to_not raise_error
    end

    it "raises an error for an invalid option" do
      expect{ demographic_path.age_gender "any option" }.
        to raise_error Semetric::Errors::Demographics::InvalidOption
    end
  end
end
