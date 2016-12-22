require "rails_helper"

module Archangel
  RSpec.describe Post, type: :model do
    before { subject.published_at = "2016-03-14 00:00:00" }

    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:author_id) }
      it { expect(subject).to validate_presence_of(:slug) }
      it { expect(subject).to validate_presence_of(:title) }

      it { expect(subject).to allow_value("").for(:content) }

      it do
        expect(subject).to allow_value("2016-01-01 00:00:00").for(:published_at)
      end
      it do
        expect(subject).to_not allow_value("not a real date").for(:published_at)
      end

      it { expect(subject).to have_db_index(:path).unique(:true) }
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:author) }

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
        create(:post, :future)

        post = create(:post)

        expect(Post.published.first).to eq(post)
      end

      it ".unpublished returns all where published_at is nil" do
        create(:post)

        post = create(:post, :future)

        expect(Post.unpublished.first).to eq(post)
      end

      it ".unpublished returns all where published_at is > now" do
        create(:post)

        post = create(:post, :unpublished)

        expect(Post.unpublished.first).to eq(post)
      end

      it ".in_year returns all where published_at is in year" do
        post = create(:post, published_at: "2015-01-01 00:00:00")

        expect(Post.in_year(2015).first).to eq(post)
      end

      it ".in_month returns all where published_at is in month" do
        post = create(:post, published_at: "2015-01-01 00:00:00")

        expect(Post.in_month(1).first).to eq(post)
      end

      it ".in_year_and_month returns all where published_at is " \
        "in year and month" do
        post = create(:post, published_at: "2015-11-24 00:00:00")

        expect(Post.in_year_and_month(2015, 11).first).to eq(post)
      end
    end
  end
end
