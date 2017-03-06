# frozen_string_literal: true

# Language select custom simple_form input field
#
# @author dfreerksen
# @since 0.0.1
#
class LanguageInput < SimpleForm::Inputs::CollectionSelectInput
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
