# frozen_string_literal: true

module Archangel
  # Theme select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ThemeInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      false
    end

    def input_options
      super.tap do |options|
        options[:include_blank] = false
      end
    end

    private

    def collection
      @collection ||= theme_options
    end

    def theme_options
      [].tap do |obj|
        Archangel.themes.each do |theme|
          obj << [Archangel.t("theme.#{theme}.name"), theme]
        end
      end
    end
  end
end
