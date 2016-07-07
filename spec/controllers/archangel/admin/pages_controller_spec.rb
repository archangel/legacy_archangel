require "rails_helper"

module Archangel
  module Admin
    RSpec.describe PagesController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all pages as @pages" do
          page = create(:page)

          archangel_get :index

          expect(assigns(:pages)).to eq([page])
        end
      end

      describe "GET #show" do
        it "assigns the requested page as @page" do
          page = create(:page)

          archangel_get :show, params: { id: page }

          expect(assigns(:page)).to eq(page)
        end
      end

      describe "GET #new" do
        it "assigns a new page as @page" do
          archangel_get :new

          expect(assigns(:page)).to be_a_new(Page)
        end
      end

      describe "GET #edit" do
        it "assigns the requested page as @page" do
          page = create(:page)

          archangel_get :edit, params: { id: page }

          expect(assigns(:page)).to eq(page)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              title: "New Page",
              slug: "new-page",
              content: "Page content",
              author_id: create(:user),
              published_at: Time.current
            }
          end

          it "creates a new Page" do
            expect do
              archangel_post :create, params: { page: params }
            end.to change(Page, :count).by(1)
          end

          it "assigns a newly created page as @page" do
            archangel_post :create, params: { page: params }

            expect(assigns(:page)).to be_a(Page)
            expect(assigns(:page)).to be_persisted
          end

          it "redirects to the created page" do
            archangel_post :create, params: { page: params }

            expect(response).to redirect_to(admin_pages_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns a newly created but unsaved page as @page" do
            archangel_post :create, params: { page: params }

            expect(assigns(:page)).to be_a_new(Page)
          end

          it "re-renders the 'new' template" do
            archangel_post :create, params: { page: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { title: "New page title" }
          end

          it "updates the requested page" do
            page = create(:page)

            archangel_put :update, params: { id: page, page: params }

            page.reload

            expect(assigns(:page)).to eq(page)
          end

          it "assigns the requested page as @page" do
            page = create(:page)

            archangel_put :update, params: { id: page, page: params }

            expect(assigns(:page)).to eq(page)
          end

          it "redirects to the page" do
            page = create(:page)

            archangel_put :update, params: { id: page, page: params }

            expect(response).to redirect_to(admin_pages_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { title: nil }
          end

          it "assigns the page as @page" do
            page = create(:page)

            archangel_put :update, params: { id: page, page: params }

            expect(assigns(:page)).to eq(page)
          end

          it "re-renders the 'edit' template" do
            page = create(:page)

            archangel_put :update, params: { id: page, page: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested page" do
          page = create(:page)

          expect do
            archangel_delete :destroy, params: { id: page }
          end.to change(Page, :count).by(-1)
        end

        it "redirects to the pages list" do
          page = create(:page)

          archangel_delete :destroy, params: { id: page }

          expect(response).to redirect_to(admin_pages_path)
        end
      end
    end
  end
end
