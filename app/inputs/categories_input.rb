# frozen_string_literal: true

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
