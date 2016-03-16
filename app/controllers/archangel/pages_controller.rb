module Archangel
  class PagesController < ApplicationController
    before_action :set_page

    def show
      respond_with @page if stale?(etag: @page, last_modified: @page.created_at)
    end

    protected

    def set_page
      # TODO: This assumes the home page is a Page and its slug is `home`.
      # Make this configurable to set any view as the home page
      if params[:path] == "home"
        redirect_to root_path, status: :moved_permanently
      end

      path = params[:path] ||= "home"

      @page = Archangel::Page.find_by!(path: path)
    end
  end
end
