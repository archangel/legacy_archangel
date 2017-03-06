# frozen_string_literal: true

module Archangel
  # Skip Authorizable concern
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module SkipAuthorizableConcern
    extend ActiveSupport::Concern

    included do
      after_action :skip_authorization
    end
  end
end
