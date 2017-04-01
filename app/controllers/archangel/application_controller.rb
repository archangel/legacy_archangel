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

    protect_from_forgery with: :exception

    helper Archangel::FlashHelper
    helper Archangel::ApplicationHelper

    rescue_from ActionController::UnknownController,
                AbstractController::ActionNotFound,
                ActionView::MissingTemplate,
                ActiveRecord::RecordNotFound, with: :render_404

    before_action :set_locale

    layout :theme_resolver

    respond_to :html, :json
    responders :flash, :http_cache

    helper_method :current_navigation
    helper_method :current_site

    # Navigation for current page
    #
    # = Example
    #  <%= current_navigation %> #=> proc
    #
    def current_navigation
      @current_navigation ||= navigation_items
    end

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
      @site ||= Archangel::Site.current
    end

    protected

    def site_theme
      "default"
    end

    def theme_resolver
      "archangel/layouts/#{site_theme}/frontend"
    end

    def per_page
      params.fetch(:limit, per_page_default)
    end

    def per_page_default
      Kaminari.config.default_per_page
    end

    def set_locale
      locale = session[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
    end

    def navigation_items
      nil
    end

    def render_404(exception)
      render_error("archangel/errors/error_404", :not_found, exception)
    end

    def render_error(path, status, exception)
      log_error(exception)

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
