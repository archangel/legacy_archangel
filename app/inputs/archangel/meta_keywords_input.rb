# frozen_string_literal: true

module Archangel
  # Mata keyword custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class MetaKeywordsInput < SimpleForm::Inputs::CollectionSelectInput
    # Input field options
    #
    # Simple Form options for field.
    #   Sets `include_blank` to `false`
    #   Sets `multiple` to `true`
    #   Sets `selected` to an array of selected keywords for the resource
    #
    def input_options
      super.tap do |options|
        options[:include_blank] = false
        options[:multiple] = true
        options[:selected] = selected_options
      end
    end

    protected

    def collection
      @collection ||= object.meta_keywords.to_s.downcase.split(",").map(&:strip)
    end

    def selected_options
      collection
    end
  end
end
