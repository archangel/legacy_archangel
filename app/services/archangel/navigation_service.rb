# frozen_string_literal: true

module Archangel
  # Navigation Service
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class NavigationService
    attr_accessor :items, :menu

    def initialize(menu = nil, items = nil)
      @menu = menu
      @items = items
    end

    def build
      return nil if menu.nil?

      proc do |primary|
        primary.selected_class = selected_class
        primary.dom_attributes = dom_attributes

        children.each do |child|
          NavigationItemService.new(child, items, primary).to_proc
        end
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

    def children
      items.reject { |item| !item.parent_id.nil? }
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
