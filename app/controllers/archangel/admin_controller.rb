# frozen_string_literal: true

module Archangel
  # Admin controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class AdminController < ApplicationController
    include Pundit

    include Archangel::AuthenticatableConcern
    include Archangel::AuthorizableConcern

    helper Archangel::AdminHelper

    rescue_from Pundit::NotAuthorizedError, with: :render_401

    protected

    def theme_resolver
      "archangel/layouts/#{site_theme}/admin"
    end
  end
end
