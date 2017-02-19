# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe ProfilesController, type: :controller do
      let!(:profile) do
        profile = create(:user)

        stub_authorization!(profile)

        profile
      end

      describe "GET #show" do
        it "assigns the current user as @profile" do
          archangel_get :show

          expect(assigns(:profile)).to eq(profile)
        end

        it "has default avatar for profile" do
          archangel_get :show

          expect(profile.avatar.url).to(
            include("/assets/archangel/resources/avatar")
          )
        end
      end

      describe "GET #edit" do
        it "assigns the current user as @profile" do
          archangel_get :edit

          expect(assigns(:profile)).to eq(profile)
        end
      end

      describe "PUT #update" do
        context "with avatar upload" do
          let(:attributes) do
            {
              avatar: fixture_file_upload(uploader_test_image)
            }
          end

          it "has avatar for @user" do
            archangel_put :update, params: { profile: attributes }

            expect(profile.avatar.url).to(
              include("/uploads/archangel/user/avatar")
            )
          end
        end

        context "with valid params, with password" do
          let(:attributes) do
            {
              name: "Fancy Name",
              password: "new password"
            }
          end

          it "assigns the current user as @profile" do
            archangel_put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end
        end

        context "with valid params, without password" do
          let(:attributes) do
            { name: "Fancy Name" }
          end

          it "assigns the current user as @profile" do
            archangel_put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end
        end

        context "with invalid params" do
          let(:attributes) do
            {
              name: "Fancy Name",
              password: "no"
            }
          end

          it "assigns the current_user as @profile" do
            archangel_put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end

          it "re-renders the 'edit' template" do
            archangel_put :update, params: { profile: attributes }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the current user" do
          expect do
            archangel_delete :destroy
          end.to change(User, :count).by(-1)
        end

        it "redirects to the root" do
          archangel_delete :destroy

          expect(response).to redirect_to(admin_root_url)
        end
      end
    end
  end
end
