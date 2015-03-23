require 'spec_helper'

describe Semetric::Event do
  describe "initialize" do
    it "raises an error for invalid event types" do
      expect{ described_class.new('any type', 'lady gaga') }.
        to raise_error Semetric::Event::InvalidType
    end
  end
end


