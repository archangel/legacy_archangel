require "rails_helper"

RSpec.describe "Role custom input for simple_form", type: :input do
  before do
    concat input_for(:foo, :select_field, as: :role)
  end

  it "applies class to field" do
    assert_select "select.role", count: 1
  end

  it "includes Archangel roles. Excludes blank" do
    assert_select "option", count: Archangel::ROLES.count
  end
end
