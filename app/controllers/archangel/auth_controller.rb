module Archangel
  class AuthController < BaseController
    helper Archangel::AuthHelper

    protected

    def theme_resolver
      "archangel/layouts/auth"
    end
  end
end
