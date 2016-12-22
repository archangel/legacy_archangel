module Archangel
  class FrontendController < ApplicationController
    helper Archangel::FrontendHelper

    protected

    def per_page
      params.fetch(:limit, 12)
    end
  end
end
