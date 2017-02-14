module Archangel
  class Navigation
    attr_accessor :menu

    def initialize
      @menu = find_navigation
    end

    def build
      return nil if menu.nil?

      proc do |primary|
        primary.selected_class = selected_class
        primary.dom_attributes = dom_attributes

        find_navigation_items.each do |menu|
          navigation_walk(menu, primary)
        end
      end
    end

    protected

    def find_navigation
      Archangel::Menu.first
    end

    def find_navigation_items
      items = Archangel::MenuItem.where(menu_id: menu, parent_id: nil)

      items = [default_navigation] if items.empty?

      items
    end

    def find_navigation_subitems_for(parent)
      Archangel::MenuItem.where(parent_id: parent.id)
    end

    def default_navigation
      Archangel::MenuItem.new(
        label: Archangel.t(:home, scope: :menu),
        url: "/"
      )
    end

    def dom_id
      menu.attr_id.empty? ? nil : menu.attr_id
    end

    def dom_class
      menu.attr_class.empty? ? "nav navbar-nav" : menu.attr_class
    end

    def dom_attributes
      { id: dom_id, class: dom_class }.compact
    end

    def selected_class
      menu.selected_class.empty? ? "selected" : menu.selected_class
    end

    def navigation_walk(item, parent)
      parent.item(item_key_for(item), item_label_for(item),
                  item_link_for(item), class: "dropdown") do |sub|
        find_navigation_subitems_for(item).each do |sub_item|
          navigation_walk(sub_item, sub)
        end
      end
    end

    def item_key_for(item)
      item.label.underscore
    end

    def item_label_for(item)
      item.label
    end

    def item_link_for(item)
      item.url
    end
  end
end
