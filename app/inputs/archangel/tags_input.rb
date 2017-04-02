# frozen_string_literal: true

module Archangel
  # Tag custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class TagsInput < SimpleForm::Inputs::CollectionSelectInput
    # Simple Form options for field.
    #   Sets `include_blank` to `false`
    #   Sets `multiple` to `true`
    #   Sets `selected` to an array of selected tags for the resource
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
      @collection ||= object.tags
    end

    def selected_options
      object.tags.map(&:id)
    end
  end
end
