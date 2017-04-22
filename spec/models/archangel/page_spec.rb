# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Page, type: :model do
    before { subject.published_at = "2016-03-14 00:00:00" }

    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:author_id) }
      it { expect(subject).to validate_presence_of(:slug) }
      it { expect(subject).to validate_presence_of(:title) }

      it { expect(subject).to allow_value("").for(:content) }
      it { expect(subject).to allow_value("").for(:path) }

      it do
        expect(subject).to allow_value("2016-01-01 00:00:00").for(:published_at)
      end
      it do
        expect(subject).to_not allow_value("not a real date").for(:published_at)
      end

      it { expect(subject).to have_db_index(:path).unique(:true) }

      it { expect(subject).to accept_nested_attributes_for(:categories) }
      it { expect(subject).to accept_nested_attributes_for(:tags) }
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:author) }

      it { expect(subject).to have_many(:assets) }
      it { expect(subject).to have_many(:categorizations) }
      it { expect(subject).to have_many(:taggings) }

      it { expect(subject).to have_many(:categories).through(:categorizations) }
      it { expect(subject).to have_many(:tags).through(:taggings) }
    end

    describe "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }
      it { expect(subject).to callback(:build_path_before_save).before(:save) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end

    describe "scopes" do
      it ".published returns all where published_at <= now" do
        create(:page, :future)

        page = create(:page)

        expect(Page.published.first).to eq(page)
      end

      it ".unpublished returns all where published_at is nil" do
        create(:page)

        page = create(:page, :future)

        expect(Page.unpublished.first).to eq(page)
      end

      it ".unpublished returns all where published_at is > now" do
        create(:page)

        page = create(:page, :unpublished)

        expect(Page.unpublished.first).to eq(page)
      end

      it ".published_this_month returns all where published_at is " \
        "this month and year" do
        current = create(:page, published_at: Time.current)
        create(:page, published_at: 1.year.ago)
        create(:page, published_at: Time.current - 1.month)

        expect(Page.published_this_month).to eq([current])
      end
    end

    context "#homepage?" do
      it "is the homepage" do
        page = build(:page, :homepage)

        expect(page.homepage?).to be_truthy
      end

      it "is not the homepage" do
        page = build(:page)

        expect(page.homepage?).to be_falsey
      end
    end

    context "#published?" do
      it "is published" do
        page = build(:page)

        expect(page.published?).to be_truthy
      end

      it "is published for the future" do
        page = build(:page, published_at: 1.week.from_now)

        expect(page.published?).to be_truthy
      end

      it "is not published" do
        page = build(:page, :unpublished)

        expect(page.published?).to be_falsey
      end
    end
  end
end
