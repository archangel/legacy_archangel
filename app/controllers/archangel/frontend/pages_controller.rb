module Archangel
  module Frontend
    # Frontend pages controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class PagesController < FrontendController
      before_action :set_page

      helper Archangel::Frontend::PagesHelper

      def show
        if redirect_to_homepage?
          return redirect_to root_path, status: :moved_permanently
        end

        respond_with @page
      end

      protected

      def set_page
        page_path = params.fetch(:path, nil)

        @page = if page_path.nil?
                  Archangel::Page.published.homepage.first
                else
                  Archangel::Page.published.find_by!(path: page_path)
                end
      end

      def redirect_to_homepage?
        return false if @page.nil?

        (params.fetch(:path, nil) == @page.path) && @page.homepage?
      end
    end
  end
end
