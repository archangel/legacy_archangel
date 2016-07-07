module Archangel
  class AuthController < BaseController
    helper Archangel::AuthHelper

    before_action :configure_permitted_parameters

    protected

    def theme_resolver
      "archangel/layouts/auth"
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username])
    end
  end
end
