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

        items.each { |item| NavigationItemService.new(item, primary).to_proc }
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
