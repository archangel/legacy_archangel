require "archangel/application_responder"

module Archangel
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception

    layout :set_layout

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    def current_site
      @site ||= Archangel::Site.current
    end

    protected

    def set_layout
      "archangel/layouts/application"
    end
  end
end
