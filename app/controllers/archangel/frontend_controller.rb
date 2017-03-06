# frozen_string_literal: true

module Archangel
  # Frontend controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class FrontendController < ApplicationController
    helper Archangel::FrontendHelper

    protected

    def per_page
      params.fetch(:limit, 12).to_i
    end
  end
end
