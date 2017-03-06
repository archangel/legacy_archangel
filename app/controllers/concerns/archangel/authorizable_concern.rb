# frozen_string_literal: true

module Archangel
  # Authorizable concern
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module AuthorizableConcern
    extend ActiveSupport::Concern

    included do
      after_action :verify_authorized
    end
  end
end
