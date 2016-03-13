require "rails_helper"

RSpec.describe "Parent page custom input for simple_form", type: :input do
  before do
    parent = create(:page)
    create(:page, parent_id: parent.id)

    concat input_for(:foo, :select_field, as: :parent_page)
  end

  it "applies class to field" do
    assert_select "select.parent_page", count: 1
  end

  it "has root option as first option" do
    option = css_select("option")[0]

    assert_equal "", option["value"]
    assert_equal Archangel.t(:top_level), option.text
  end

  it "has options" do
    assert_select "option", count: 3
  end
end
