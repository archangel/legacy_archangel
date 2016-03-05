module Archangel
  class PagesController < ApplicationController
    before_action :set_page

    def show
      respond_with @page
    end

    protected

    def set_page
      @page = Archangel::Page.find_by!(path: params[:path] ||= "")
    end
  end
end
