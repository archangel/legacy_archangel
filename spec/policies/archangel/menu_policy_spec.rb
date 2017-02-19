# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe MenuPolicy, type: :policy do
    subject { MenuPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:menu) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
