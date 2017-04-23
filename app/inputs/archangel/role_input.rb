# frozen_string_literal: true

module Archangel
  # Role select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class RoleInput < SimpleForm::Inputs::CollectionSelectInput
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
end
