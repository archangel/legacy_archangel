# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe ApplicationUploader, type: :uploader do
    it "allows certain extensions" do
      expect(subject.extension_whitelist).to eq %i[gif jpeg jpg png]
    end
  end
end
