require "archangel/application_responder"

module Archangel
  class BaseController < ActionController::Base
    include Archangel::ActionableConcern

    protect_from_forgery with: :exception

    layout :theme_resolver

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    def current_site
      @site ||= Archangel::Site.current
    end

    protected

    def theme_resolver
      "archangel/layouts/application"
    end
  end
end
