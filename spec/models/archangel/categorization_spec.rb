require "rails_helper"

module Archangel
  RSpec.describe Categorization, type: :model do
    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:categorizable) }
      it { expect(subject).to belong_to(:category) }

      it { expect(subject).to have_many(:categorizations) }
    end
  end
end
