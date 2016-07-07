require "rails_helper"

module Archangel
  module Admin
    RSpec.describe CategoriesController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all categories as @categories" do
          category = create(:category)

          archangel_get :index

          expect(assigns(:categories)).to eq([category])
        end
      end

      describe "GET #show" do
        it "assigns the requested category as @category" do
          category = create(:category)

          archangel_get :show, params: { id: category }

          expect(assigns(:category)).to eq(category)
        end
      end

      describe "GET #new" do
        it "assigns a new category as @category" do
          archangel_get :new

          expect(assigns(:category)).to be_a_new(Category)
        end
      end

      describe "GET #edit" do
        it "assigns the requested category as @category" do
          category = create(:category)

          archangel_get :edit, params: { id: category }

          expect(assigns(:category)).to eq(category)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "New Category",
              slug: "new-category"
            }
          end

          it "creates a new Category" do
            expect do
              archangel_post :create, params: { category: params }
            end.to change(Category, :count).by(1)
          end

          it "assigns a newly created category as @category" do
            archangel_post :create, params: { category: params }

            expect(assigns(:category)).to be_a(Category)
            expect(assigns(:category)).to be_persisted
          end

          it "redirects to the created category" do
            archangel_post :create, params: { category: params }

            expect(response).to redirect_to(admin_categories_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns a newly created but unsaved category as @category" do
            archangel_post :create, params: { category: params }

            expect(assigns(:category)).to be_a_new(Category)
          end

          it "re-renders the 'new' template" do
            archangel_post :create, params: { category: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { name: "New category name" }
          end

          it "updates the requested category" do
            category = create(:category)

            archangel_put :update, params: { id: category, category: params }

            category.reload

            expect(assigns(:category)).to eq(category)
          end

          it "assigns the requested category as @category" do
            category = create(:category)

            archangel_put :update, params: { id: category, category: params }

            expect(assigns(:category)).to eq(category)
          end

          it "redirects to the category" do
            category = create(:category)

            archangel_put :update, params: { id: category, category: params }

            expect(response).to redirect_to(admin_categories_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns the category as @category" do
            category = create(:category)

            archangel_put :update, params: { id: category, category: params }

            expect(assigns(:category)).to eq(category)
          end

          it "re-renders the 'edit' template" do
            category = create(:category)

            archangel_put :update, params: { id: category, category: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested category" do
          category = create(:category)

          expect do
            archangel_delete :destroy, params: { id: category }
          end.to change(Category, :count).by(-1)
        end

        it "redirects to the category list" do
          category = create(:category)

          archangel_delete :destroy, params: { id: category }

          expect(response).to redirect_to(admin_categories_path)
        end
      end
    end
  end
end
