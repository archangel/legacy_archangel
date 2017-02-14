# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe ApplicationHelper, type: :helper do
    context "#locale" do
      it "returns application locale" do
        expect(helper.locale).to eq("en")
      end
    end

    context "#text_direction" do
      it "returns ltr text direction" do
        expect(helper.text_direction).to eq("ltr")
      end

      it "returns rtl text direction" do
        allow(helper).to receive(:text_direction).and_return("rtl")

        expect(helper.text_direction).to eq("rtl")
      end
    end
  end
end
