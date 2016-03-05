module Archangel
  module TestingSupport
    module AuthorizationHelpers
      def stub_authorization!(user = double("user"))
        user.nil? ? stub_nil_authorization : stub_user_authorization(user)
      end

      private

      def stub_nil_authorization
        allow(request.env["warden"]).to(receive(:authenticate!))
                                    .and_throw(:warden, scope: :user)
        allow(controller).to receive(:current_user).and_return(nil)
      end

      def stub_user_authorization(user)
        allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::AuthorizationHelpers,
                 type: :controller
end
