# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe AdminController, type: :controller do
    describe "GET #custom" do
      it "uses correct layout" do
        routes.draw { get "custom" => "archangel/admin#custom" }

        get :custom

        expect(response).to render_with_layout("archangel/layouts/admin")
      end
    end
  end
end
