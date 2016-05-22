module Archangel
  class AdminController < ApplicationController
    include Pundit

    include Archangel::AuthenticatableConcern
    include Archangel::AuthorizableConcern

    unless Rails.application.config.consider_all_requests_local
      rescue_from Pundit::NotAuthorizedError, with: :render_401
    end

    protected

    def theme_resolver
      "archangel/layouts/admin"
    end
  end
end
