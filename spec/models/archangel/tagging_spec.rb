# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Tagging, type: :model do
    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:tag) }
      it { expect(subject).to belong_to(:taggable) }
    end
  end
end
