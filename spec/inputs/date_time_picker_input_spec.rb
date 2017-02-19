# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Date time picker custom input for simple_form", type: :input do
  before do
    concat input_for(:foo, :input_field, as: :date_time_picker)
  end

  it "applies class to field" do
    assert_select "input.datetimepicker", count: 1
  end

  it "includes group icon" do
    assert_select "i.glyphicon.glyphicon-calendar", count: 1
  end
end
