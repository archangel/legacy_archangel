require "rails_helper"

module Archangel
  module Admin
    RSpec.describe ProfilesController, type: :controller do
      let!(:profile) do
        profile = create(:user, :admin)

        stub_authorization!(profile)

        profile
      end

      describe "GET #show" do
        it "assigns the current user as @profile" do
          archangel_get :show

          expect(assigns(:profile)).to eq(profile)
        end
      end

      describe "GET #edit" do
        it "assigns the current user as @profile" do
          get :edit

          expect(assigns(:profile)).to eq(profile)
        end
      end

      describe "PUT #update" do
        context "with valid params, with password" do
          let(:attributes) do
            {
              name: "Fancy Name",
              password: "new password"
            }
          end

          it "assigns the current user as @profile" do
            archangel_put :update, profile: attributes

            expect(assigns(:profile)).to eq(profile)
          end
        end

        context "with valid params, without password" do
          let(:attributes) do
            { name: "Fancy Name" }
          end

          it "assigns the current user as @profile" do
            archangel_put :update, profile: attributes

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
            archangel_put :update, profile: attributes

            expect(assigns(:profile)).to eq(profile)
          end

          it "re-renders the 'edit' template" do
            archangel_put :update, profile: attributes

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

      describe "POST #retoken" do
        it "regenerates `api_key` for the requested user" do
          archangel_post :retoken

          expect(response).to redirect_to(admin_profile_path)
        end
      end
    end
  end
end
