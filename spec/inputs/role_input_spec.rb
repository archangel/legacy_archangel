require "rails_helper"

RSpec.describe "Role custom input for simple_form", type: :input do
  before { concat input_for(:foo, :select_field, as: :role) }

  it "applies class to field" do
    assert_select "select.role", count: 1
  end

  it "has options" do
    assert_select "option", count: Archangel::ROLES.count
  end
end
