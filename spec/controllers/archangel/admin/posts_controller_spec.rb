require "rails_helper"

module Archangel
  module Admin
    RSpec.describe PostsController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all posts as @posts" do
          post = create(:post)

          archangel_get :index

          expect(assigns(:posts)).to eq([post])
        end
      end

      describe "GET #show" do
        it "assigns the requested post as @post" do
          post = create(:post)

          archangel_get :show, id: post

          expect(assigns(:post)).to eq(post)
        end
      end

      describe "GET #new" do
        it "assigns a new post as @post" do
          archangel_get :new

          expect(assigns(:post)).to be_a_new(Post)
        end
      end

      describe "GET #edit" do
        it "assigns the requested post as @post" do
          post = create(:post)

          archangel_get :edit, id: post

          expect(assigns(:post)).to eq(post)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "Awesome Post",
              slug: "awesome-post"
            }
          end

          it "creates a new Post" do
            expect do
              archangel_post :create, post: params
            end.to change(Post, :count).by(1)
          end

          it "assigns a newly created post as @post" do
            archangel_post :create, post: params

            expect(assigns(:post)).to be_a(Post)
            expect(assigns(:post)).to be_persisted
          end

          it "redirects to the created post" do
            archangel_post :create, post: params

            expect(response).to redirect_to(admin_posts_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns a newly created but unsaved post as @post" do
            archangel_post :create, post: params

            expect(assigns(:post)).to be_a_new(Post)
          end

          it "re-renders the 'new' template" do
            archangel_post :create, post: params

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { name: "New post name" }
          end

          it "updates the requested post" do
            post = create(:post)

            archangel_put :update, id: post, post: params

            post.reload

            expect(assigns(:post)).to eq(post)
          end

          it "assigns the requested post as @post" do
            post = create(:post)

            archangel_put :update, id: post, post: params

            expect(assigns(:post)).to eq(post)
          end

          it "redirects to the post" do
            post = create(:post)

            archangel_put :update, id: post, post: params

            expect(response).to redirect_to(admin_posts_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns the post as @post" do
            post = create(:post)

            archangel_put :update, id: post, post: params

            expect(assigns(:post)).to eq(post)
          end

          it "re-renders the 'edit' template" do
            post = create(:post)

            archangel_put :update, id: post, post: params

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested post" do
          post = create(:post)

          expect do
            archangel_delete :destroy, id: post
          end.to change(Post, :count).by(-1)
        end

        it "redirects to the posts list" do
          post = create(:post)

          archangel_delete :destroy, id: post

          expect(response).to redirect_to(admin_posts_path)
        end
      end
    end
  end
end
