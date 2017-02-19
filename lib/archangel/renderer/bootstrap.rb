# frozen_string_literal: true

module Archangel
  module Renderer
    class Bootstrap < SimpleNavigation::Renderer::Base
      def render(item_container)
        return "" if skip_if_empty? && item_container.empty?

        tag = options[:ordered] ? :ol : :ul
        content = list_content(item_container)
        attributes = container_attributes(item_container)

        content_tag(tag, content, attributes)
      end

      private

      def container_class(level)
        level == 1 ? nil : "dropdown"
      end

      def container_attributes(item_container)
        attributes = {
          id: item_container.dom_id,
          class: item_container.dom_class
        }

        attributes[:class] = [
          attributes[:class],
          container_class(item_container.level)
        ].flatten.compact.join(" ")

        if item_container.respond_to?(:dom_attributes)
          attributes = item_container.dom_attributes
        end

        attributes
      end

      def list_content(item_container)
        item_container.items.inject([]) do |list, item|
          li_options = item.html_options.reject { |k, _v| k == :link }
          icon = li_options.delete(:icon)
          li_content = tag_for(item, icon)

          if include_sub_navigation?(item)
            li_content << render_sub_navigation_for(item)
          end

          list << content_tag(:li, li_content, li_options)
        end.join
      end

      def tag_for(item, icon = nil)
        item_name = list_item_name(item.name, icon)

        list_item_link(item, item_name)
      end

      def list_item_name(item_name, icon = nil)
        unless icon.nil?
          icon = content_tag(:i, "", class: [icon].flatten.compact.join(" "))
        end

        [icon, content_tag(:span, item_name)].compact.join(" ")
      end

      def list_item_link(item, item_name)
        if suppress_link?(item)
          content_tag("span", item_name, link_options_for(item).except(:method))
        else
          link_to(item_name, item.url, options_for(item))
        end
      end
    end
  end
end
