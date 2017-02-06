require "rails_helper"

module Archangel
  RSpec.describe MenuItem, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:label) }

      it { expect(subject).to allow_value("").for(:method) }
      it { expect(subject).to allow_value("").for(:url) }

      it do
        expect(subject).to validate_inclusion_of(:method)
          .in_array(Archangel::MENU_METHODS)
      end

      it { expect(subject).to accept_nested_attributes_for(:menu_items) }
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:menu) }
      it { expect(subject).to belong_to(:menuable) }
      it { expect(subject).to belong_to(:parent) }
    end

    describe "callbacks" do
      it { expect(subject).to callback(:column_default).after(:initialize) }
    end
  end
end
