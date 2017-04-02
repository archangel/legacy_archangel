# frozen_string_literal: true

module Archangel
  # Language select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
    # Do not allow multiple selections
    #
    # @return [Boolean] false
    #
    def multiple?
      false
    end

    # Input field options
    #
    # Simple Form options for field.
    #   Sets `include_blank` to `false`
    #
    def input_options
      super.tap do |options|
        options[:include_blank] = false
      end
    end

    protected

    def collection
      @collection ||= build_options
    end

    def build_options
      [].tap do |obj|
        Archangel::LANGUAGES.each do |translation|
          obj << [Archangel.t("languages.#{translation}"), translation]
        end
      end
    end
  end
end
