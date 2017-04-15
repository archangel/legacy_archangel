# frozen_string_literal: true

module Archangel
  # Navigation Item Service
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class NavigationItemService
    attr_accessor :item, :items, :primary

    attr_reader :children, :key, :label, :link, :highlights_on, :html,
                :link_html

    def initialize(item, items, primary)
      self.item = item
      self.items = items
      self.primary = primary
    end

    def key
      @key ||= item.label.underscore
    end

    def label
      @label ||= item.label
    end

    def link
      @link ||= build_link
    end

    def highlights_on
      @highlights_on ||= build_highlights_on
    end

    def html
      @html ||= build_html
    end

    def link_html
      @link_html ||= build_link_html
    end

    def children
      @children ||= build_children
    end

    def to_proc
      if children.any?
        primary.item(key, label, link, build_options) do |secondary|
          children.each do |child|
            NavigationItemService.new(child, items, secondary).to_proc
          end
        end
      else
        primary.item(key, label, link, build_options)
      end
    end

    protected

    def build_link
      return item.url unless item.url.blank?

      return nil if item.menuable.nil?

      routes = Archangel.routes

      return routes.root_path if check_homepage?

      routes.frontend_page_path(item.menuable.path)
    end

    def build_options
      {
        highlights_on: highlights_on,
        html: html,
        link_html: link_html
      }
    end

    def build_highlights_on
      return false if item.url =~ URI.regexp

      highlight_on = item.highlights_on

      return Regexp.new(highlight_on) unless highlight_on.blank?

      build_menuable_highlights_on
    end

    def build_menuable_highlights_on
      menuable_object = item.menuable

      return nil if menuable_object.nil?

      return %r{/$} if check_homepage?

      Regexp.new(Archangel.routes.frontend_page_path(menuable_object.path))
    end

    def build_html
      attributes = { id: item.attr_id, class: item.attr_class }.compact

      if children.any?
        attributes[:class] = [
          attributes[:class], "dropdown"
        ].reject(&:blank?).join(" ")
      end

      attributes
    end

    def build_link_html
      { class: item.link_attr_class }.compact
    end

    def build_children
      items.reject { |itm| itm.parent_id != item.id }
    end

    def check_homepage?
      item.menuable.homepage?
    rescue
      false
    end
  end
end
