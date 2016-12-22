require "rails_helper"

module Archangel
  RSpec.describe FrontendController, type: :controller do
    describe "GET #custom" do
      it "uses correct layout" do
        routes.draw { get "custom" => "archangel/frontend#custom" }

        get :custom

        expect(response).to render_with_layout("archangel/layouts/frontend")
      end
    end
  end
end
