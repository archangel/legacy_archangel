require "rails_helper"

module Archangel
  RSpec.describe AdminHelper, type: :helper do
    context "#author_link(obj)" do
      let!(:profile) { create(:user) }

      before { allow(helper).to receive(:current_user).and_return(profile) }

      it "returns current user" do
        expect(helper.author_link(profile)).to have_link(
          profile.name,
          href: archangel.admin_profile_path
        )
      end

      it "returns author" do
        author = create(:user)

        expect(helper.author_link(author)).to have_link(
          author.name,
          href: archangel.admin_user_path(author)
        )
      end

      it "returns `Unknown` without author" do
        expect(helper.author_link(nil)).to eq Archangel.t(:unknown)
      end
    end

    context "#datepicker_field_value(date, now)" do
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

    context "#datetimepicker_field_value(date, now)" do
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
