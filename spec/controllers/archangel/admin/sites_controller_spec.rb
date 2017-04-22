# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe SitesController, type: :controller do
      before { stub_authorization! }

      describe "GET #show" do
        it "assigns the requested site as @site" do
          archangel_get :show

          expect(assigns(:site)).to eq(Site.current)
        end
      end

      describe "GET #edit" do
        it "assigns the requested site as @site" do
          archangel_get :edit

          expect(assigns(:site)).to eq(Site.current)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              name: "My Archangel Site",
              theme: "default"
            }
          end

          it "updates the requested setting" do
            archangel_put :update, params: { site: params }

            Site.current.reload

            expect(assigns(:site)).to eq(Site.current)
          end

          it "assigns the requested site as @site" do
            archangel_put :update, params: { site: params }

            expect(assigns(:site)).to eq(Site.current)
          end

          it "redirects to the site" do
            archangel_put :update, params: { site: params }

            expect(response).to redirect_to(admin_site_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              theme: nil
            }
          end

          it "assigns the site as @site" do
            archangel_put :update, params: { site: params }

            expect(assigns(:site)).to eq(Site.current)
          end

          it "re-renders the 'edit' template" do
            archangel_put :update, params: { site: params }

            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
