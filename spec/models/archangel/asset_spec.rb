require "rails_helper"

module Archangel
  RSpec.describe Asset, type: :model do
    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:assetable) }
      it { expect(subject).to belong_to(:uploader) }
    end
  end
end
