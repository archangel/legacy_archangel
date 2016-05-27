require "rails_helper"

module Archangel
  module Admin
    RSpec.describe TagsController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all tags as @tags" do
          tag = create(:tag)

          archangel_get :index

          expect(assigns(:tags)).to eq([tag])
        end
      end

      describe "GET #show" do
        it "assigns the requested tag as @tag" do
          tag = create(:tag)

          archangel_get :show, id: tag

          expect(assigns(:tag)).to eq(tag)
        end
      end

      describe "GET #new" do
        it "assigns a new tag as @tag" do
          archangel_get :new

          expect(assigns(:tag)).to be_a_new(Tag)
        end
      end

      describe "GET #edit" do
        it "assigns the requested tag as @tag" do
          tag = create(:tag)

          archangel_get :edit, id: tag

          expect(assigns(:tag)).to eq(tag)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "Awesome Tag",
              slug: "awesome-tag"
            }
          end

          it "creates a new Tag" do
            expect do
              archangel_post :create, tag: params
            end.to change(Tag, :count).by(1)
          end

          it "assigns a newly created tag as @tag" do
            archangel_post :create, tag: params

            expect(assigns(:tag)).to be_a(Tag)
            expect(assigns(:tag)).to be_persisted
          end

          it "redirects to the created tag" do
            archangel_post :create, tag: params

            expect(response).to redirect_to(admin_tags_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns a newly created but unsaved tag as @tag" do
            archangel_post :create, tag: params

            expect(assigns(:tag)).to be_a_new(Tag)
          end

          it "re-renders the 'new' template" do
            archangel_post :create, tag: params

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { name: "New tag name" }
          end

          it "updates the requested tag" do
            tag = create(:tag)

            archangel_put :update, id: tag, tag: params

            tag.reload

            expect(assigns(:tag)).to eq(tag)
          end

          it "assigns the requested tag as @tag" do
            tag = create(:tag)

            archangel_put :update, id: tag, tag: params

            expect(assigns(:tag)).to eq(tag)
          end

          it "redirects to the tag" do
            tag = create(:tag)

            archangel_put :update, id: tag, tag: params

            expect(response).to redirect_to(admin_tags_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns the tag as @tag" do
            tag = create(:tag)

            archangel_put :update, id: tag, tag: params

            expect(assigns(:tag)).to eq(tag)
          end

          it "re-renders the 'edit' template" do
            tag = create(:tag)

            archangel_put :update, id: tag, tag: params

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested tag" do
          tag = create(:tag)

          expect do
            archangel_delete :destroy, id: tag
          end.to change(Tag, :count).by(-1)
        end

        it "redirects to the tags list" do
          tag = create(:tag)

          archangel_delete :destroy, id: tag

          expect(response).to redirect_to(admin_tags_path)
        end
      end
    end
  end
end
