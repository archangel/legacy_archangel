require "rails_helper"

module Archangel
  RSpec.describe BaseUploader, type: :uploader do
    it "allows certain extensions" do
      expect(subject.extension_white_list).to eq %w(gif jpeg jpg png)
    end
  end
end
