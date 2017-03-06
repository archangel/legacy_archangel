# frozen_string_literal: true

# Role select custom simple_form input field
#
# @author dfreerksen
# @since 0.0.1
#
class RoleInput < SimpleForm::Inputs::CollectionSelectInput
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
    @collection ||= role_options
  end

  def role_options
    [].tap do |obj|
      Archangel::ROLES.each do |role|
        obj << [Archangel.t("roles.#{role}"), role]
      end
    end
  end
end
