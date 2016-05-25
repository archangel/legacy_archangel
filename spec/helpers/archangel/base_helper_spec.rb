require "rails_helper"

module Archangel
  RSpec.describe BaseHelper, type: :helper do
    context "locale attribute" do
      it "returns application locale" do
        expect(helper.locale).to eq(:en)
      end
    end
  end
end
