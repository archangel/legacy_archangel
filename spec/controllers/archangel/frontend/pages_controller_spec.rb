require "rails_helper"

module Archangel
  module Frontend
    RSpec.describe PagesController, type: :controller do
      describe "GET #show" do
        it "assigns the requested page as @page" do
          page = create(:page)

          archangel_get :show, params: { path: page.path }

          expect(assigns(:page)).to eq(page)
        end
      end
    end
  end
end
