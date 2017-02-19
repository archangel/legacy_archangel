# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe User, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:email) }
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:password).on(:create) }
      it { expect(subject).to validate_presence_of(:username) }

      it do
        expect(subject).to validate_length_of(:password)
          .is_at_least(8)
          .is_at_most(72)
      end

      it { expect(subject).to allow_value("me@example.com").for(:email) }
      it { expect(subject).to_not allow_value("example.com").for(:email) }

      it { expect(subject).to have_db_index(:email).unique(:true) }
      it { expect(subject).to have_db_index(:username).unique(:true) }
    end

    describe "callbacks" do
      it do
        expect(subject).to callback(:parameterize_username).before(:validation)
      end

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end
  end
end
