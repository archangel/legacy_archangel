# frozen_string_literal: true

module Archangel
  # Parent page select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ParentPageInput < SimpleForm::Inputs::CollectionSelectInput
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
    #   Sets `prompt` to translated root text
    #   Sets `disabled` to an resource ID if the object is persisted
    #
    def input_options
      super.tap do |options|
        options[:include_blank] = false
        options[:prompt] = Archangel.t(:top_level)
        options[:disabled] = [object.id] if object && object.persisted?
      end
    end

    protected

    def collection
      @collection ||= build_tree_options
    end

    def build_tree_options(node = nil, level = 0)
      nodes = node.nil? ? Archangel::Page.roots : node.children

      nodes.each_with_object([]) do |child, structure|
        structure << ["#{"-" * (level * 2)}#{child.title}", child.id]

        children = build_tree_options(child, level + 1)

        structure.concat(children) if children.any?
      end
    end
  end
end
