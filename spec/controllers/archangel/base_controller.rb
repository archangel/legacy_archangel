require "rails_helper"

module Archangel
  RSpec.describe BaseController, type: :controller do
    describe "GET #custom" do
      it "uses correct layout" do
        routes.draw { get "custom" => "archangel/base#custom" }

        get :custom

        expect(response).to render_with_layout("archangel/layouts/application")
      end
    end
  end
end
