require "rails_helper"

module Archangel
  module Admin
    RSpec.describe SitesController, type: :controller do
      before { stub_authorization! }

      describe "GET #show" do
        it "assigns the requested site as @site" do
          archangel_get :show

          expect(assigns(:site)).to eq(Site.first)
        end
      end

      describe "GET #edit" do
        it "assigns the requested site as @site" do
          archangel_get :edit

          expect(assigns(:site)).to eq(Site.first)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            { title: "My Archangel" }
          end

          it "updates the requested setting" do
            archangel_put :update, site: params

            Site.first.reload

            expect(assigns(:site)).to eq(Site.first)
          end

          it "assigns the requested site as @site" do
            archangel_put :update, site: params

            expect(assigns(:site)).to eq(Site.first)
          end

          it "redirects to the site" do
            archangel_put :update, site: params

            expect(response).to redirect_to(admin_site_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            { title: nil }
          end

          it "assigns the site as @site" do
            archangel_put :update, site: params

            expect(assigns(:site)).to eq(Site.first)
          end

          it "re-renders the 'edit' template" do
            archangel_put :update, site: params

            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
