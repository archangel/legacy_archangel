require "rails_helper"

module Archangel
  RSpec.describe FlashHelper, type: :helper do
    context "flash_class_for attribute" do
      it "returns known alert class" do
        expect(helper.flash_class_for("success")).to eq("success")
      end

      it "returns unknown alert class" do
        expect(helper.flash_class_for("unknown")).to eq("unknown")
      end
    end
  end
end
