# frozen_string_literal: true

module Archangel
  # Application responder
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ApplicationResponder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    # Redirects resources to the collection path (index action) instead
    # of the resource path (show action) for POST/PUT/DELETE requests.
    # include Responders::CollectionResponder
  end
end
