# frozen_string_literal: true

module Archangel
  module Frontend
    # Frontend posts helpers
    #
    # @author dfreerksen
    # @since 0.0.1
    #
    module PostsHelper
      # Author link
      #
      # Link for post author profile page. Currently does not link since there
      # are no author profiles.
      #
      # = Example
      #   "<%= author_link(resource.author) %>"
      #     #=> "admin_user_path(resource.author)"
      #   "<%= author_link(resource.author) %>"
      #     #=> "admin_profile_path # when current user"
      #
      # @param [Archangel::Post] post
      #                          post resource
      # @return [String] link to post author
      #
      def author_link(post)
        link_to(post.author.name, "#")
      end

      # Post publish date
      #
      # = Example
      #   "<%= posted_at(resource) %>"
      #
      # @param [Archangel::Post] post
      #                          post resource
      # @return [String] time HTML element for post date
      #
      def posted_at(post)
        published_at = post.published_at

        post_date = published_at.strftime("%B %e, %Y at %l:%M %p")
        post_datetime = published_at.strftime("%FT%T%:z")

        content_tag(:time, post_date, pubdate: "", datetime: post_datetime)
      end

      # Post path
      #
      # = Example
      #   "<%= post_path(resource) %>" #=> "frontend_page_path(resource.path)"
      #
      # @param [Archangel::Post] post
      #                          post resource
      # @return [String] link to post
      #
      def post_path(post)
        full_path = "#{Archangel.config.posts_path}/#{post.path}"

        archangel.frontend_page_path(full_path)
      end

      # Post url
      #
      # = Example
      #   "<%= post_url(resource) %>" #=> "frontend_page_url(resource.path)"
      #
      # @param [Archangel::Post] post
      #                          post resource
      # @return [String] link to post
      #
      def post_url(post)
        path = post_path(post).gsub!(%r{^/}, "")

        archangel.frontend_page_url(path)
      end
    end
  end
end
