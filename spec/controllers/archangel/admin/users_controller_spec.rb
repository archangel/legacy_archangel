# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe UsersController, type: :controller do
      before { stub_authorization! create(:user) }

      describe "GET #index" do
        it "assigns all users as @users" do
          user = create(:user)

          archangel_get :index

          expect(assigns(:users)).to eq([user])
        end
      end

      describe "GET #show" do
        it "assigns the requested user as @user" do
          user = create(:user)

          archangel_get :show, params: { id: user }

          expect(assigns(:user)).to eq(user)
        end
      end

      describe "GET #new" do
        it "assigns a new user as @user" do
          archangel_get :new

          expect(assigns(:user)).to be_a_new(User)
        end
      end

      describe "GET #edit" do
        it "assigns the requested user as @user" do
          user = create(:user)

          archangel_get :edit, params: { id: user.to_param }

          expect(assigns(:user)).to eq(user)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:attributes) do
            {
              name: "Fake User",
              username: "fake_user",
              email: "fake_user@example.com"
            }
          end

          it "creates a new User" do
            expect do
              archangel_post :create, params: { user: attributes }
            end.to change(User, :count).by(1)
          end

          it "assigns a newly created user as @user" do
            archangel_post :create, params: { user: attributes }

            expect(assigns(:user)).to be_a(User)
            expect(assigns(:user)).to be_persisted
          end

          it "redirects to the created user" do
            archangel_post :create, params: { user: attributes }

            expect(response).to redirect_to(admin_users_path)
          end
        end

        context "with invalid params" do
          let(:existing_user) { create(:user) }
          let(:attributes) do
            { email: existing_user.email }
          end

          it "re-renders the 'new' template" do
            archangel_post :create, params: { user: attributes }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:attributes) do
            { email: "new_email@example.com" }
          end

          it "assigns the requested user as @user" do
            user = create(:user)

            archangel_put :update,
                          params: { id: user.to_param, user: attributes }

            expect(assigns(:user)).to eq(user)
          end

          it "redirects to the user" do
            user = create(:user)

            archangel_put :update,
                          params: { id: user.to_param, user: attributes }

            expect(response).to redirect_to(admin_users_path)
          end
        end

        context "with invalid params" do
          let(:existing_user) { create(:user) }
          let(:attributes) do
            { email: existing_user.email }
          end

          it "assigns the user as @user" do
            user = create(:user)

            archangel_put :update,
                          params: { id: user.to_param, user: attributes }

            expect(assigns(:user)).to eq(user)
          end

          it "re-renders the 'edit' template" do
            user = create(:user)

            archangel_put :update,
                          params: { id: user.to_param, user: attributes }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested user" do
          user = create(:user)

          expect do
            archangel_delete :destroy, params: { id: user.to_param }
          end.to change(User, :count).by(-1)
        end

        it "redirects to the users list" do
          user = create(:user)

          archangel_delete :destroy, params: { id: user.to_param }

          expect(response).to redirect_to(admin_users_path)
        end
      end
    end
  end
end
