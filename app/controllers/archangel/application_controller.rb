module Archangel
  class ApplicationController < BaseController
    unless Rails.application.config.consider_all_requests_local
      rescue_from ActionController::RoutingError, with: :render_401
      rescue_from ActionController::UnknownController,
                  AbstractController::ActionNotFound,
                  ActionView::MissingTemplate,
                  ActiveRecord::RecordNotFound, with: :render_404
    end

    protected

    def per_page
      params[:limit] || Kaminari.config.default_per_page
    end

    def render_401(exception)
      render_error("archangel/errors/error_401", :unauthorized, exception)
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
  end
end
