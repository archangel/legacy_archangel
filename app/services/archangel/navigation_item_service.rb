# frozen_string_literal: true

module Archangel
  # Navigation Item Service
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class NavigationItemService
    attr_accessor :item, :primary

    attr_reader :key, :label, :link, :highlights_on, :html, :link_html

    def initialize(item, primary)
      self.item = item
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

    def to_proc
      primary.item(key, label, link, highlights_on: highlights_on,
                                     html: html,
                                     link_html: link_html) do |secondary|
        item.children.each do |child|
          NavigationItemService.new(child, secondary).to_proc
        end
      end
    end

    protected

    def build_link
      return item.url unless item.url.blank?

      item.menuable.homepage? ? "/" : item.menuable.path
    end

    def build_highlights_on
      unless item.highlights_on.blank?
        return %r{#{Regexp.escape(item.highlights_on)}}
      end

      return proc { false } if item.url =~ URI.regexp

      build_menuable_highlights_on
    end

    def build_menuable_highlights_on
      menuable_object = item.menuable

      return proc { false } if menuable_object.nil?

      return %r{/$} if menuable_object.homepage?

      %r{#{Regexp.escape(menuable_object.path)}}
    end

    def build_html
      attributes = { id: item.attr_id, class: item.attr_class }.compact

      if item.children.any?
        attributes[:class] = [
          attributes[:class], "dropdown"
        ].reject(&:blank?).join(" ")
      end

      attributes
    end

    def build_link_html
      { class: item.link_attr_class }.compact
    end
  end
end
