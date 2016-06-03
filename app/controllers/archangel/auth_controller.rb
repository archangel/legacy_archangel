module Archangel
  class AuthController < BaseController
    helper Archangel::AuthHelper

    before_filter :configure_permitted_parameters

    protected

    def theme_resolver
      "archangel/layouts/auth"
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :name, :password, :password_confirmation, :username)
      end
    end
  end
end
