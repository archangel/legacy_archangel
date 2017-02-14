# frozen_string_literal: true

module Archangel
  module Frontend
    # Frontend posts helpers
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module PostsHelper
      def author_link(post)
        link_to(post.author.name, "#")
      end

      def posted_at(post)
        post_date = post.published_at.strftime("%B %e, %Y at %l:%M %p")
        post_datetime = post.published_at.strftime("%FT%T%:z")

        content_tag(:time, post_date, pubdate: "", datetime: post_datetime)
      end

      def post_path(post)
        full_path = "#{Archangel.configuration.posts_path}/#{post.path}"

        archangel.frontend_page_path(full_path)
      end

      def post_url(post)
        path = post_path(post).gsub!(%r{^/}, "")

        archangel.frontend_page_url(path)
      end
    end
  end
end
