require "archangel/application_responder"

module Archangel
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception

    layout :set_layout

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :settings

    def settings
      @settings ||= Archangel::Setting.settings
    end

    protected

    def set_layout
      "archangel/layouts/application"
    end
  end
end
