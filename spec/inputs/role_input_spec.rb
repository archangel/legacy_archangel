require "rails_helper"

RSpec.describe "Role custom input for simple_form", type: :input do
  before do
    concat input_for(:foo, :role, as: :role)
  end

  it "does not includes blank" do
    assert_select "option[value=]", count: Archangel::ROLES.count
  end
end
