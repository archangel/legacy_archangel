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

    helper_method :current_site

    protected

    def current_site
      @site ||= Archangel::Site.current
    end

    def site_theme
      "default"
    end

    def theme_resolver
      "archangel/layouts/#{site_theme}/frontend"
    end

    def per_page
      params.fetch(:limit, Kaminari.config.default_per_page)
    end

    def set_locale
      locale = params[:locale].to_s.strip.to_sym

      I18n.locale = locale_for(locale)
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
      Rails.logger.error status.to_s + " " + exception.message.to_s
      Rails.logger.error exception.backtrace.join("\n")
    end

    private

    def locale_for(locale)
      I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    end
  end
end
