require "rails_helper"

module Archangel
  RSpec.describe PostsController, type: :controller do
    describe "GET #index" do
      it "assigns all posts as @posts" do
        posts = create_list(:post, 3)

        archangel_get :index

        expect(assigns(:posts)).to eq(posts.reverse)
      end

      it "assigns all posts for year as @posts" do
        excluded_post = create(:post, published_at: 1.year.ago)
        posts = create_list(:post, 3)

        archangel_get :index, params: {
          year: Time.now.year
        }

        expect(assigns(:posts)).not_to include(excluded_post)
        expect(assigns(:posts)).to eq(posts.reverse)
      end

      it "assigns all posts for year and month as @posts" do
        excluded_post = create(:post, published_at: 1.year.ago)
        posts = create_list(:post, 3)

        archangel_get :index, params: {
          year: Time.now.year,
          month: "%02d" % Time.now.month
        }

        expect(assigns(:posts)).not_to include(excluded_post)
        expect(assigns(:posts)).to eq(posts.reverse)
      end
    end

    describe "GET #show" do
      it "uses correct layout" do
        post = create(:post)

        archangel_get :show, params: {
          year: post.published_at.year,
          month: "%02d" % post.published_at.month,
          slug: post.slug
        }

        expect(response).to(
          render_template(layout: "archangel/layouts/application")
        )
      end

      it "assigns the requested post as @post" do
        post = create(:post)

        archangel_get :show, params: {
          year: post.published_at.year,
          month: "%02d" % post.published_at.month,
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
        [
          published_post_a, published_post_b, unpublished_post, future_post,
          deleted_post
        ].each do |post|
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
        [
          published_post_a, published_post_b, unpublished_post, future_post,
          deleted_post
        ].each do |post|
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


#
# let(:category) { create(:category) }
#
# let(:published_post) { create(:post) }
# let(:published_post) { create(:post) }
# let(:unpublished_post) { create(:post, :unpublished) }
# let(:future_post) { create(:post, :future) }
# let(:deleted_post) { create(:post, :deleted) }
#
# before do
#   [
#     published_post, published_post, unpublished_post, future_post,
#     deleted_post
#   ].each do |post|
#     create(:categorization, categorizable: post, category: category)
#   end
# end
