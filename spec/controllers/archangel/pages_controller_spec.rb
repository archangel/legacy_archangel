require "rails_helper"

module Archangel
  RSpec.describe PagesController, type: :controller do
    describe "GET #show" do
      it "uses correct layout" do
        create(:page, :homepage)

        archangel_get :show

        expect(response).to(
          render_template(layout: "archangel/layouts/application")
        )
      end

      xit "assigns the requested page as @page" do
        page = create(:page)

        archangel_get :show, path: page

        expect(assigns(:page)).to eq(page)
      end
    end
  end
end
