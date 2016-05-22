module Archangel
  class AuthController < BaseController
    protected

    def theme_resolver
      "archangel/layouts/auth"
    end
  end
end
