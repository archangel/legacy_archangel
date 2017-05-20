# frozen_string_literal: true

module Archangel
  # Gyphicon helpers
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  module GlyphiconHelper
    # Create an icon tag for Bootstrap icons.
    #
    # Based on fa_icon helper from Font Awesome Rails
    #
    # = Example
    #
    #   glyphicon_icon("heart") # =>
    #     <span class="glyphicon glyphicon-heart" aria-hidden="true"></span>
    #
    #   glyphicon_icon("heart", text: "Heart") # =>
    #     <span class="glyphicon glyphicon-heart"," aria-hidden="true"></span> Heart
    #
    #   glyphicon_icon("user", data: { id: 123 }, text: "User 123") # =>
    #     <span class="glyphicon glyphicon-user" data-id="123" aria-hidden="true"></span> User 123
    #
    # @param [String, Symbol] name
    #                         icon name
    # @param [Array] original_options
    #                options
    # @return [String] Bootstrap icon
    #
    def glyphicon_icon(name = "flag", original_options = {})
      options = original_options.deep_dup
      classes = [
        "glyphicon",
        "glyphicon-#{name}",
        options.delete(:class)
      ].reject(&:blank?).flatten
      text = options.delete(:text)
      icon = content_tag(:span, nil, options.merge(class: classes,
                                                   aria: { hidden: true }))
      Private.icon_join(icon, text)
    end

    # Gyphicon private helpers
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module Private
      extend ActionView::Helpers::OutputSafetyHelper

      def self.icon_join(icon, text)
        return icon if text.blank?

        elements = [icon, ERB::Util.html_escape(text)]

        safe_join(elements, " ")
      end
    end
  end
end
