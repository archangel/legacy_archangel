# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Configuration, type: :library do
    it "has integer values" do
      expect(Archangel.config.asset_maximum_file_size).to(
        be_a_kind_of(Integer)
      )
    end

    it "has string values" do
      expect(Archangel.config.application).to be_a_kind_of(String)
    end

    it "has array of values" do
      expect(Archangel.config.asset_white_list).to be_a_kind_of(Array)
    end

    describe "#missing_method" do
      it "returns value for key" do
        expect(Archangel.config.application).to eq "archangel"
      end

      it "checks for availability of key" do
        expect(Archangel.config.application?).to be_truthy
      end

      it "returns default (nil) value for key not found" do
        expect(Archangel.config.unavailable_key).to eq nil
      end

      it "checks for availability of unavailable key" do
        expect(Archangel.config.unavailable_key?).to be_falsey
      end
    end
  end
end
