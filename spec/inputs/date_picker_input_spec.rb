require "rails_helper"

RSpec.describe "Date picker custom input for simple_form", type: :input do
  before do
    concat input_for(:foo, :input_field, as: :date_picker)
  end

  it "applies class to field" do
    assert_select "input.datepicker", count: 1
  end

  it "includes group icon" do
    assert_select "i.glyphicon.glyphicon-calendar", count: 1
  end
end
