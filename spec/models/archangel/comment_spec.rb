require "rails_helper"

module Archangel
  RSpec.describe Comment, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:message) }

      it { expect(subject).to allow_value("").for(:author_id) }
      it { expect(subject).to allow_value("").for(:email) }
      it { expect(subject).to allow_value("").for(:name) }

      it { expect(subject).to allow_value("me@example.com").for(:email) }
      it { expect(subject).to_not allow_value("example.com").for(:email) }

      it do
        expect(subject).to allow_value("2016-01-01 00:00:00").for(:approved_at)
      end
      it do
        expect(subject).to_not allow_value("not a real date").for(:approved_at)
      end
    end

    describe "ActiveRecord associations" do
      it { expect(subject).to belong_to(:author) }
      it { expect(subject).to belong_to(:commentable) }

      it do
        expect(subject).to belong_to(:parent).with_foreign_key(:parent_id)
      end

      it do
        expect(subject).to have_many(:children).with_foreign_key(:parent_id)
      end
    end

    describe "scopes" do
      it ".unapproved returns all where approved_at is nil" do
        comment = create(:comment, :unapproved)

        expect(Comment.unapproved.first).to eq(comment)
      end

      it ".for_source returns all where page has comments" do
        page = create(:page)
        comments = create_list(:comment, 3, commentable: page)

        expect(Comment.for_source(page)).to eq(comments)
      end
    end
  end
end
