# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Admin
    RSpec.describe DashboardsController, type: :controller do
      before { stub_authorization! }

      describe "GET #show" do
        it "assigns the requested issue as @issue" do
          archangel_get :show

          expect(response).to render_template(:show)
        end
      end
    end
  end
end
