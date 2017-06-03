# frozen_string_literal: true

module Archangel
  # Themable concern
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module ThemableConcern
    extend ActiveSupport::Concern

    # Themable concern class methods
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module ClassMethods
      def theme(theme, options = {})
        @_theme = theme
        @_theme_options = options

        Archangel::Theme::ThemableController.apply_theme(self, theme, options)
      end
    end
  end
end
