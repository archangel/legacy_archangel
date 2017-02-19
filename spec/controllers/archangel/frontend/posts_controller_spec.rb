# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PostsController, type: :controller do
      describe "GET #index" do
        let!(:posts) { create_list(:post, 3) }

        it "assigns all posts as @posts" do
          archangel_get :index

          expect(assigns(:posts)).to eq(posts.reverse)
        end

        it "assigns all posts as @posts with default pagination" do
          create_list(:post, 10)

          archangel_get :index

          expect(assigns(:posts).count).to eq(12)
        end

        it "assigns all posts as @posts with custom pagination" do
          archangel_get :index, params: {
            limit: 2
          }

          expect(assigns(:posts).count).to eq(2)
          expect(assigns(:posts)).to eq(posts[1, 2].reverse)
        end

        it "assigns all posts for year as @posts" do
          excluded_post = create(:post, published_at: 1.year.ago)

          archangel_get :index, params: {
            year: Time.now.utc.year
          }

          expect(assigns(:posts)).not_to include(excluded_post)
          expect(assigns(:posts)).to eq(posts.reverse)
        end

        it "assigns all posts for year and month as @posts" do
          excluded_post = create(:post, published_at: 1.year.ago)

          archangel_get :index, params: {
            year: Time.now.utc.year,
            month: format("%02d", Time.now.utc.month)
          }

          expect(assigns(:posts)).not_to include(excluded_post)
          expect(assigns(:posts)).to eq(posts.reverse)
        end
      end

      describe "GET #show" do
        it "assigns the requested post as @post" do
          post = create(:post)

          archangel_get :show, params: {
            year: post.published_at.year,
            month: format("%02d", post.published_at.month),
            slug: post.slug
          }

          expect(assigns(:post)).to eq(post)
        end
      end

      describe "GET #category" do
        let(:category) { create(:category) }

        let(:published_post_a) { create(:post) }
        let(:published_post_b) { create(:post) }
        let(:unpublished_post) { create(:post, :unpublished) }
        let(:future_post) { create(:post, :future) }
        let(:deleted_post) { create(:post, :deleted) }
        let(:untagged_post) { create(:post) }

        before do
          [published_post_a, published_post_b, unpublished_post].each do |post|
            create(:categorization, categorizable: post, category: category)
          end
        end

        it "assigns all posts in category as @posts" do
          archangel_get :category, params: {
            slug: category
          }

          expect(assigns(:posts)).not_to include(unpublished_post)
          expect(assigns(:posts)).not_to include(future_post)
          expect(assigns(:posts)).not_to include(deleted_post)
          expect(assigns(:posts)).not_to include(untagged_post)
          expect(assigns(:posts)).to eq([published_post_b, published_post_a])
        end
      end

      describe "GET #tag" do
        let(:tag) { create(:tag) }

        let(:published_post_a) { create(:post) }
        let(:published_post_b) { create(:post) }
        let(:unpublished_post) { create(:post, :unpublished) }
        let(:future_post) { create(:post, :future) }
        let(:deleted_post) { create(:post, :deleted) }
        let(:untagged_post) { create(:post) }

        before do
          [published_post_a, published_post_b, unpublished_post].each do |post|
            create(:tagging, taggable: post, tag: tag)
          end
        end

        it "assigns all posts in category as @posts" do
          archangel_get :tag, params: {
            slug: tag
          }

          expect(assigns(:posts)).not_to include(unpublished_post)
          expect(assigns(:posts)).not_to include(future_post)
          expect(assigns(:posts)).not_to include(deleted_post)
          expect(assigns(:posts)).not_to include(untagged_post)
          expect(assigns(:posts)).to eq([published_post_b, published_post_a])
        end
      end
    end
  end
end
