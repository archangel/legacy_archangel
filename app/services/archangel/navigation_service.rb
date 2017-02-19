# frozen_string_literal: true

module Archangel
  # Navigation Service
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class NavigationService
    attr_accessor :menu

    def initialize(menu = nil)
      @menu = menu
    end

    def build
      return nil if menu.nil?

      proc do |primary|
        primary.selected_class = selected_class
        primary.dom_attributes = dom_attributes

        items.each { |item| build_menu_item(item, primary) }
      end
    end

    protected

    def selected_class
      property(:selected_class, "selected")
    end

    def dom_attributes
      { id: dom_id, class: dom_class }.compact
    end

    def dom_id
      property(:attr_id, nil)
    end

    def dom_class
      property(:attr_class, "nav navbar-nav")
    end

    def items
      menu.menu_items
    rescue
      []
    end

    def build_menu_item(item, primary)
      children = item.children

      highlights_on = highlights_on_for(item)
      html_options = html_options_for(item)
      link_html_options = link_html_options_for(item)

      primary.item(key_for(item), label_for(item), link_for(item),
                   highlights_on: highlights_on,
                   html: html_options, link_html: link_html_options) do |sub|
        children.each { |child| build_menu_item(child, sub) } if children.any?
      end
    end

    def key_for(item)
      item.label.underscore
    end

    def label_for(item)
      item.label
    end

    def link_for(item)
      item.url
    end

    def highlights_on_for(_item)
      # %r(/books)
      proc { false }
    end

    def html_options_for(item)
      attributes = { id: item.attr_id, class: item.attr_class }.compact

      if item.children.any?
        attributes[:class] = [
          attributes[:class],
          "dropdown"
        ].reject(&:blank?).join(" ")
      end

      attributes
    end

    def link_html_options_for(item)
      { class: item.link_attr_class }.compact
    end

    private

    def property(key, default_value = nil)
      property?(key) ? menu[key] : default_value
    end

    def property?(key)
      menu.respond_to?(key) && !menu[key].blank?
    end
  end
end
