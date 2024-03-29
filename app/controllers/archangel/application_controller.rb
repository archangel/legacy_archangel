# frozen_string_literal: true

require "archangel/application_responder"

module Archangel
  # Application controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationController < ActionController::Base
    include Archangel::ActionableConcern
    include Archangel::PaginatableConcern
    include Archangel::ThemableConcern

    protect_from_forgery with: :exception

    helper Archangel::ApplicationHelper
    helper Archangel::FlashHelper
    helper Archangel::GlyphiconHelper

    rescue_from ActionController::UnknownController,
                AbstractController::ActionNotFound,
                ActionView::MissingTemplate,
                ActiveRecord::RecordNotFound, with: :render_404

    before_action :set_locale

    theme :theme_resolver

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_site

    # Current site
    #
    # = Example
    #  <%= current_site %> #=> object
    #
    # = Response
    #   {
    #     "id": 123,
    #     "name": "Site Name",
    #     "locale": "en",
    #     "logo": {
    #       "url": "/path/to/logo.jpg",
    #       "medium": {
    #         "url": "/path/to/medium_logo.jpg"
    #       },
    #       "thumb": {
    #         "url": "/path/to/thumb_logo.jpg"
    #       },
    #       "mini": {
    #         "url": "/path/to/mini_logo.jpg"
    #       }
    #     },
    #     "meta_keywords": "site, keywords",
    #     "meta_description": "Site description",
    #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
    #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
    #     "theme": "default",
    #     "favicon": null
    #   }
    #
    def current_site
      @current_site ||= Archangel::Site.current
    end

    protected

    def theme_resolver
      theme = current_site.theme

      Archangel::THEMES.include?(theme) ? theme : Archangel::THEME_DEFAULT
    end

    def layout_from_theme
      "frontend"
    end

    def set_locale
      locale = session[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
    end

    def render_404(exception = nil)
      render_error("archangel/errors/error_404", :not_found, exception)
    end

    def render_error(path, status, exception = nil)
      log_error(exception) unless exception.blank?

      respond_to do |format|
        format.html { render(template: path, status: status) }
        format.json { render(template: path, status: status) }
      end
    end

    def log_error(exception)
      logger = Rails.logger

      logger.error status.to_s + " " + exception.message.to_s
      logger.error exception.backtrace.join("\n")
    end

    private

    def locale_for(locale)
      I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end
  end
end
