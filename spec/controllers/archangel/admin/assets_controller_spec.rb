# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe AssetsController, type: :controller do
      before { stub_authorization! create(:user) }

      describe "GET #index" do
        it "assigns all assets as @assets" do
          assets = create_list(:asset, 2)

          archangel_get :index

          expect(assigns(:assets)).to eq(assets.reverse)
        end
      end

      describe "GET #show" do
        it "assigns the requested asset as @asset" do
          asset = create(:asset)

          archangel_get :show, params: { id: asset }

          expect(assigns(:asset)).to eq(asset)
        end

        it "builds url using uploaded image" do
          asset = create(:asset)

          expect(asset.file.mini.url).to(
            include("/uploads/archangel/asset/file/#{asset.id}/mini_image.gif")
          )
        end

        context "with non-image file" do
          before do
            Archangel.config.attachment_white_list.insert(0, "txt")
          end

          after do
            Archangel.config.attachment_white_list.delete_at(0)
          end

          it "builds url using default image" do
            asset = create(:asset, :text_file)

            expect(asset.file.mini.url).to(
              match(%r{/assets/archangel/mini_asset(.*).png})
            )
          end
        end
      end

      describe "GET #new" do
        it "assigns a new asset as @asset" do
          archangel_get :new

          expect(assigns(:asset)).to be_a_new(Asset)
        end
      end

      describe "GET #edit" do
        it "assigns the requested asset as @asset" do
          asset = create(:asset)

          archangel_get :edit, params: { id: asset }

          expect(assigns(:asset)).to eq(asset)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              file: fixture_file_upload(uploader_test_image)
            }
          end

          it "creates a new Asset" do
            expect do
              archangel_post :create, params: { asset: params }
            end.to change(Asset, :count).by(1)
          end

          it "assigns a newly created asset as @asset" do
            archangel_post :create, params: { asset: params }

            expect(assigns(:asset)).to be_a(Asset)
            expect(assigns(:asset)).to be_persisted
          end

          it "redirects to the created asset" do
            archangel_post :create, params: { asset: params }

            expect(response).to redirect_to(admin_assets_path)
          end
        end

        context "XHR with valid params" do
          let(:params) do
            {
              file: fixture_file_upload(uploader_test_image)
            }
          end

          it "is in JSON format" do
            archangel_xhr_post :create, params: params

            expect(response.header["Content-Type"]).to(
              include "application/json"
            )
          end

          it "creates a new Asset" do
            expect do
              archangel_xhr_post :create, params: params
            end.to change(Asset, :count).by(1)
          end

          it "assigns a newly created asset as @asset" do
            archangel_xhr_post :create, params: params

            expect(assigns(:asset)).to be_a(Asset)
            expect(assigns(:asset)).to be_persisted
          end

          it "redirects to the created asset" do
            archangel_xhr_post :create, params: params

            parsed_response = JSON.parse(response.body)

            expect(parsed_response["success"]).to be_truthy
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              file: fixture_file_upload(uploader_test_image)
            }
          end

          it "updates the requested asset" do
            asset = create(:asset)

            archangel_put :update, params: { id: asset, asset: params }

            asset.reload

            expect(assigns(:asset)).to eq(asset)
          end

          it "assigns the requested asset as @asset" do
            asset = create(:asset)

            archangel_put :update, params: { id: asset, asset: params }

            expect(assigns(:asset)).to eq(asset)
          end

          it "redirects to the asset" do
            asset = create(:asset)

            archangel_put :update, params: { id: asset, asset: params }

            expect(response).to redirect_to(admin_assets_path)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested asset" do
          asset = create(:asset)

          expect do
            archangel_delete :destroy, params: { id: asset }
          end.to change(Asset, :count).by(-1)
        end

        it "redirects to the assets list" do
          asset = create(:asset)

          archangel_delete :destroy, params: { id: asset }

          expect(response).to redirect_to(admin_assets_path)
        end
      end
    end
  end
end
