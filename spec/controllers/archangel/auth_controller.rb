# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AuthController, type: :controller do
    describe "GET #custom" do
      it "uses correct layout" do
        routes.draw { get "custom" => "archangel/auth#custom" }

        get :custom

        expect(response).to render_with_layout("archangel/layouts/auth")
      end
    end
  end
end
