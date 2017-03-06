# frozen_string_literal: true

module Archangel
  # Parent page select custom simple_form input field
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class ParentPageInput < SimpleForm::Inputs::CollectionSelectInput
    def multiple?
      false
    end

    def input_options
      super.tap do |options|
        options[:include_blank] = false
        options[:prompt] = Archangel.t(:top_level)
        options[:disabled] = [object.id] if object && object.persisted?
      end
    end

    private

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
