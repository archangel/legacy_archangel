# frozen_string_literal: true

module Archangel
  # Admin controller
  #
  # @author dfreerksen
  # @since 0.0.1
  #
  class AdminController < ApplicationController
    include Pundit

    include Archangel::AuthenticatableConcern
    include Archangel::AuthorizableConcern

    helper Archangel::AdminHelper

    rescue_from Pundit::NotAuthorizedError, with: :render_401

    protected

    def theme_resolver
      "archangel/layouts/#{site_theme}/admin"
    end

    def navigation_items
      proc do |primary|
        primary.dom_attributes = { id: "sidebar-menu", class: "nav hidden-xs" }

        primary.item :dashboard,
                     Archangel.t(:dashboard, scope: :menu),
                     admin_root_path,
                     html: { icon: "fa fa-lg fa-th-large" },
                     highlights_on: %r{/admin$}
        primary.item :pages,
                     Archangel.t(:pages, scope: :menu),
                     admin_pages_path,
                     html: { icon: "fa fa-lg fa-files-o" },
                     highlights_on: %r{admin/pages}
        primary.item :posts,
                     Archangel.t(:posts, scope: :menu),
                     admin_posts_path,
                     html: { icon: "fa fa-lg fa-rss" },
                     highlights_on: %r{admin/posts}
        primary.item :categories,
                     Archangel.t(:categories, scope: :menu),
                     admin_categories_path,
                     html: { icon: "fa fa-lg fa-list-ul" },
                     highlights_on: %r{admin/categories}
        primary.item :tags,
                     Archangel.t(:tags, scope: :menu),
                     admin_tags_path,
                     html: { icon: "fa fa-lg fa-tags" },
                     highlights_on: %r{admin/tags}
        primary.item :users,
                     Archangel.t(:users, scope: :menu),
                     admin_users_path,
                     html: { icon: "fa fa-lg fa-users" },
                     highlights_on: %r{admin/users}
        primary.item :menus,
                     Archangel.t(:menus, scope: :menu),
                     admin_menus_path,
                     html: { icon: "fa fa-lg fa-bars" },
                     highlights_on: %r{admin/menus}
        primary.item :assets,
                     Archangel.t(:assets, scope: :menu),
                     admin_assets_path,
                     html: { icon: "fa fa-lg fa-object-group" },
                     highlights_on: %r{admin/assets}
        primary.item :site,
                     Archangel.t(:site, scope: :menu),
                     admin_site_path,
                     html: { icon: "fa fa-lg fa-globe" },
                     highlights_on: %r{admin/site}
      end
    end
  end
end
