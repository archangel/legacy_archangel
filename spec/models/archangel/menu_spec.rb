require "rails_helper"

module Archangel
  RSpec.describe Menu, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to have_db_index(:slug).unique(:true) }

      it { expect(subject).to accept_nested_attributes_for(:menu_items) }
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to have_many(:menu_items) }
    end

    describe "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end
  end
end
