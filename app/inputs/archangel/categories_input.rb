# frozen_string_literal: true

module Archangel
  # Category select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class CategoriesInput < SimpleForm::Inputs::CollectionSelectInput
    def input_options
      super.tap do |options|
        options[:include_blank] = false
        options[:multiple] = true
        options[:selected] = selected_options
      end
    end

    protected

    def collection
      @collection ||= object.categories
    end

    def selected_options
      object.categories.map(&:id)
    end
  end
end
