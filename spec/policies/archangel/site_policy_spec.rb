# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe SitePolicy, type: :policy do
    subject { SitePolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:site) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
