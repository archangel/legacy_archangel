require "rails_helper"

module Archangel
  RSpec.describe Category, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to have_db_index(:slug).unique(:true) }
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to have_many(:categorizations) }

      it { expect(subject).to have_many(:pages).through(:categorizations) }
    end

    describe "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end
  end
end
