# frozen_string_literal: true

class MetaKeywordsInput < SimpleForm::Inputs::CollectionSelectInput
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
