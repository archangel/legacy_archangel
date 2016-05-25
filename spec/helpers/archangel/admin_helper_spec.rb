require "rails_helper"

module Archangel
  RSpec.describe AdminHelper, type: :helper do
    context "date picker field" do
      it "uses current, formatted date for value" do
        now = Time.current

        expect(helper.datepicker_field_value(nil, true)).to eq(
          now.strftime("%F")
        )
      end

      it "uses specified, formatted date for value" do
        date = DateTime.parse("1979-11-24 06:24:18")

        expect(helper.datepicker_field_value(date)).to eq("1979-11-24")
      end

      it "sets the date to empty with empty date" do
        expect(helper.datepicker_field_value(nil)).to eq nil
      end
    end

    context "date time picker field" do
      it "uses current, formatted date for value" do
        now = Time.current

        expect(helper.datetimepicker_field_value(nil, true)).to eq(
          now.strftime("%F %R")
        )
      end

      it "uses specified, formatted date for value" do
        date = DateTime.parse("1979-11-24 06:24:18")

        expect(helper.datetimepicker_field_value(date)).to eq(
          "1979-11-24 06:24"
        )
      end

      it "sets the date to empty with empty date" do
        expect(helper.datetimepicker_field_value(nil)).to eq nil
      end
    end
  end
end
