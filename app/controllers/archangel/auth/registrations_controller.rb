# frozen_string_literal: true

module Archangel
  module Auth
    # Auth registrations controller
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    class RegistrationsController < Devise::RegistrationsController
      before_action :something, only: %i[cancel create destroy edit new update]

      protected

      def something
        return render_404 unless Archangel.config.allow_registration == true
      end
    end
  end
end
