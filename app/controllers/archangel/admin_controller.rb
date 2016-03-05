module Archangel
  class AdminController < ApplicationController
    include Pundit

    before_action :authenticate_user!
    after_action :verify_authorized

    unless Rails.application.config.consider_all_requests_local
      rescue_from Pundit::NotAuthorizedError, with: :render_401
    end

    protected

    def set_layout
      "archangel/layouts/admin"
    end
  end
end
