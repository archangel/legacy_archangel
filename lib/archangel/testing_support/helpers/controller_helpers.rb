module Archangel
  module TestingSupport
    module ControllerHelpers
      extend ActiveSupport::Concern

      included do
        routes { Archangel::Engine.routes }
      end

      def archangel_get(action, *args)
        process_archangel_action(action, :get, *args)
      end

      def archangel_post(action, *args)
        process_archangel_action(action, :post, *args)
      end

      def archangel_put(action, *args)
        process_archangel_action(action, :put, *args)
      end

      def archangel_delete(action, *args)
        process_archangel_action(action, :delete, *args)
      end

      def archangel_xhr_get(action, *args)
        process_archangel_xhr_action(action, :get, *args)
      end

      def archangel_xhr_post(action, *args)
        process_archangel_xhr_action(action, :post, *args)
      end

      def archangel_xhr_put(action, *args)
        process_archangel_xhr_action(action, :put, *args)
      end

      def archangel_xhr_patch(action, *args)
        process_archangel_xhr_action(action, :patch, *args)
      end

      def archangel_xhr_delete(action, *args)
        process_archangel_xhr_action(action, :delete, *args)
      end

      private

      def process_archangel_action(action, method = :get, *args)
        params = args.first.blank? ? {} : args.first

        params[:method] = method

        process(action, params)
      end

      def process_archangel_xhr_action(action, method = :get, *args)
        params = args.first.blank? ? {} : args.first

        params.merge!(
          method: method,
          format: :json,
          xhr: true
        )

        process(action, params)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::ControllerHelpers, type: :controller
end
