module Archangel
  module Frontend
    class PagesController < FrontendController
      before_action :set_page

      helper Archangel::Frontend::PagesHelper

      def show
        respond_with @page
      end

      protected

      def set_page
        # TODO: This assumes the home page is a Page and its slug is `home`.
        # Make this configurable to set any page as the home page
        redirect_to root_path, status: :moved_permanently if intended_home_page?

        path = params[:path] ||= "home"

        @page = Archangel::Page.find_by!(path: path)
      end

      def intended_home_page?
        params[:path] == "home"
      end
    end
  end
end
