module Archangel
  class PagesController < ApplicationController
    before_action :set_page

    def show
      respond_with @page if stale?(etag: @page, last_modified: @page.created_at)
    end

    protected

    def set_page
      @page = Archangel::Page.find_by!(path: params[:path] ||= "home")
    end
  end
end
