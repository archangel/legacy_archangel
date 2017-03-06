# frozen_string_literal: true

module Archangel
  # Authenticatable concern
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module AuthenticatableConcern
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!
    end
  end
end
