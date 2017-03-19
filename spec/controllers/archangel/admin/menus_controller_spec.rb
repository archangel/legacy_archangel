# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe MenusController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all menus as @menus" do
          menu = create(:menu)

          archangel_get :index

          expect(assigns(:menus)).to eq([menu])
        end
      end

      describe "GET #show" do
        it "assigns the requested menu as @menu" do
          menu = create(:menu)

          archangel_get :show, params: { id: menu }

          expect(assigns(:menu)).to eq(menu)
        end
      end

      describe "GET #new" do
        it "assigns a new menu as @menu" do
          archangel_get :new

          expect(assigns(:menu)).to be_a_new(Menu)
        end
      end

      describe "GET #edit" do
        it "assigns the requested menu as @menu" do
          menu = create(:menu)

          archangel_get :edit, params: { id: menu }

          expect(assigns(:menu)).to eq(menu)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "Awesome Menu",
              slug: "awesome-menu"
            }
          end

          it "creates a new Menu" do
            expect do
              archangel_post :create, params: { menu: params }
            end.to change(Menu, :count).by(1)
          end

          it "assigns a newly created menu as @menu" do
            archangel_post :create, params: { menu: params }

            expect(assigns(:menu)).to be_a(Menu)
            expect(assigns(:menu)).to be_persisted
          end

          it "redirects to the created menu" do
            archangel_post :create, params: { menu: params }

            expect(response).to redirect_to(admin_menus_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns a newly created but unsaved menu as @menu" do
            archangel_post :create, params: { menu: params }

            expect(assigns(:menu)).to be_a_new(Menu)
          end

          it "re-renders the 'new' template" do
            archangel_post :create, params: { menu: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { name: "New menu name" }
          end

          it "updates the requested menu" do
            menu = create(:menu)

            archangel_put :update, params: { id: menu, menu: params }

            menu.reload

            expect(assigns(:menu)).to eq(menu)
          end

          it "assigns the requested menu as @menu" do
            menu = create(:menu)

            archangel_put :update, params: { id: menu, menu: params }

            expect(assigns(:menu)).to eq(menu)
          end

          it "redirects to the menu" do
            menu = create(:menu)

            archangel_put :update, params: { id: menu, menu: params }

            expect(response).to redirect_to(admin_menus_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { name: nil }
          end

          it "assigns the menu as @menu" do
            menu = create(:menu)

            archangel_put :update, params: { id: menu, menu: params }

            expect(assigns(:menu)).to eq(menu)
          end

          it "re-renders the 'edit' template" do
            menu = create(:menu)

            archangel_put :update, params: { id: menu, menu: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested menu" do
          menu = create(:menu)

          expect do
            archangel_delete :destroy, params: { id: menu }
          end.to change(Menu, :count).by(-1)
        end

        it "redirects to the menus list" do
          menu = create(:menu)

          archangel_delete :destroy, params: { id: menu }

          expect(response).to redirect_to(admin_menus_path)
        end
      end
    end
  end
end
