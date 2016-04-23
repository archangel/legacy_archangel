require "securerandom"

module Archangel
  module TokenService
    def generate
      SecureRandom.urlsafe_base64(nil, false)
    end
  end
end
