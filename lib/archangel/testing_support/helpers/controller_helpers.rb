module Archangel
  module TestingSupport
    module ControllerHelpers
      extend ActiveSupport::Concern

      included do
        routes { Archangel::Engine.routes }
      end

      def archangel_get(action, parameters = nil, session = nil, flash = nil)
        process_archangel_action(action, parameters, session, flash, :get)
      end

      def archangel_post(action, parameters = nil, session = nil, flash = nil)
        process_archangel_action(action, parameters, session, flash, :post)
      end

      def archangel_put(action, parameters = nil, session = nil, flash = nil)
        process_archangel_action(action, parameters, session, flash, :put)
      end

      def archangel_delete(action, parameters = nil, session = nil, flash = nil)
        process_archangel_action(action, parameters, session, flash, :delete)
      end

      def archangel_xhr_get(action,
                            parameters = nil,
                            session = nil,
                            flash = nil)
        process_archangel_xhr_action(action, parameters, session, flash, :get)
      end

      def archangel_xhr_post(action,
                             parameters = nil,
                             session = nil,
                             flash = nil)
        process_archangel_xhr_action(action, parameters, session, flash, :post)
      end

      def archangel_xhr_put(action,
                            parameters = nil,
                            session = nil,
                            flash = nil)
        process_archangel_xhr_action(action, parameters, session, flash, :put)
      end

      def archangel_xhr_patch(action,
                              parameters = nil,
                              session = nil,
                              flash = nil)
        process_archangel_xhr_action(action, parameters, session, flash, :patch)
      end

      def archangel_xhr_delete(action,
                               parameters = nil,
                               session = nil,
                               flash = nil)
        process_archangel_xhr_action(action,
                                     parameters,
                                     session,
                                     flash,
                                     :delete)
      end

      private

      def process_archangel_action(action,
                                   parameters = nil,
                                   session = nil,
                                   flash = nil,
                                   method = :get)
        parameters ||= {}

        process(action, method.to_s.upcase, parameters, session, flash)
      end

      def process_archangel_xhr_action(action,
                                       parameters = nil,
                                       session = nil,
                                       flash = nil,
                                       method = :get)
        parameters ||= {}
        parameters.reverse_merge!(format: :json)

        xml_http_request(method, action, parameters, session, flash)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::ControllerHelpers, type: :controller
end
