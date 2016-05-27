module Archangel
  module AuthorizableConcern
    extend ActiveSupport::Concern

    included do
      after_action :verify_authorized
    end
  end
end