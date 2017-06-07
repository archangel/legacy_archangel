# frozen_string_literal: true

Archangel::Engine.routes.draw do
  # Pagination
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  # GET    /account/login
  # POST   /account/login
  # DELETE /account/logout
  # POST   /account/password
  # GET    /account/password/new
  # GET    /account/password/edit
  # PATCH  /account/password
  # PUT    /account/password
  # GET    /account/cancel
  # POST   /account
  # GET    /account/register
  # GET    /account/edit
  # PATCH  /account
  # PUT    /account
  # DELETE /account
  # POST   /account/verification
  # GET    /account/verification/new
  # GET    /account/verification
  # POST   /account/unlock
  # GET    /account/unlock/new
  # GET    /account/unlock
  # GET    /account/invitation/accept
  # GET    /account/invitation/remove
  # POST   /account/invitation
  # GET    /account/invitation/new
  # PATCH  /account/invitation
  # PUT    /account/invitation
  devise_for :users,
             module: :devise,
             class_name: "Archangel::User",
             controllers: {
               registrations: "archangel/auth/registrations"
             },
             path: "",
             path_prefix: Archangel.config.auth_path,
             skip: [:omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "register",
               password: "password",
               confirmation: "verification",
               unlock: "unlock"
             }
  get Archangel.config.auth_path,
      to: redirect("#{Archangel.config.auth_path}/login")

  namespace :admin, path: Archangel.config.admin_path do
    # GET    /admin/assets
    # GET    /admin/assets/page/[PAGE]
    # POST   /admin/assets
    # GET    /admin/assets/new
    # GET    /admin/assets/[ID]/edit
    # GET    /admin/assets/[ID]
    # PATCH  /admin/assets/[ID]
    # PUT    /admin/assets/[ID]
    # DELETE /admin/assets/[ID]
    resources :assets, concerns: [:paginatable]

    # GET    /admin/categories
    # GET    /admin/categories/page/[PAGE]
    # POST   /admin/categories
    # GET    /admin/categories/new
    # GET    /admin/categories/[ID]/edit
    # GET    /admin/categories/[ID]
    # PATCH  /admin/categories/[ID]
    # PUT    /admin/categories/[ID]
    # DELETE /admin/categories/[ID]
    # GET    /admin/categories/autocomplete
    resources :categories, concerns: [:paginatable] do
      collection do
        get "autocomplete", defaults: { format: :json }
      end
    end

    # GET    /admin/menus
    # GET    /admin/menus/page/[PAGE]
    # POST   /admin/menus
    # GET    /admin/menus/new
    # GET    /admin/menus/[ID]/edit
    # GET    /admin/menus/[ID]
    # PATCH  /admin/menus/[ID]
    # PUT    /admin/menus/[ID]
    # DELETE /admin/menus/[ID]
    resources :menus

    # GET    /admin/pages
    # GET    /admin/pages/page/[PAGE]
    # POST   /admin/pages
    # GET    /admin/pages/new
    # GET    /admin/pages/[ID]/edit
    # GET    /admin/pages/[ID]
    # PATCH  /admin/pages/[ID]
    # PUT    /admin/pages/[ID]
    # DELETE /admin/pages/[ID]
    resources :pages, concerns: [:paginatable]

    # GET /admin/posts
    # GET /admin/posts/page/[PAGE]
    # GET /admin/posts
    # POST /admin/posts
    # GET /admin/posts/new
    # GET /admin/posts/[ID]/edit
    # GET /admin/posts/[ID]
    # PATCH /admin/posts/[ID]
    # PUT /admin/posts/[ID]
    # DELETE /admin/posts/[ID]
    resources :posts, concerns: [:paginatable]

    # GET    /admin/profile/edit
    # GET    /admin/profile
    # PATCH  /admin/profile
    # PUT    /admin/profile
    # DELETE /admin/profile
    resource :profile, except: %i[create new]

    # GET   /admin/site/edit
    # GET   /admin/site
    # PATCH /admin/site
    # PUT   /admin/site
    resource :site, only: %i[edit show update]

    # GET    /admin/tags
    # GET    /admin/tags/page/[PAGE]
    # POST   /admin/tags
    # GET    /admin/tags/new
    # GET    /admin/tags/[ID]/edit
    # GET    /admin/tags/[ID]
    # PATCH  /admin/tags/[ID]
    # PUT    /admin/tags/[ID]
    # DELETE /admin/tags/[ID]
    # GET    /admin/tags/autocomplete
    resources :tags, concerns: [:paginatable] do
      collection do
        get "autocomplete", defaults: { format: :json }
      end
    end

    # GET    /admin/users
    # GET    /admin/users/page/[PAGE]
    # POST   /admin/users
    # GET    /admin/users/new
    # GET    /admin/users/[USERNAME]/edit
    # GET    /admin/users/[USERNAME]
    # PATCH  /admin/users/[USERNAME]
    # PUT    /admin/users/[USERNAME]
    # DELETE /admin/users/[USERNAME]
    resources :users, concerns: [:paginatable]

    # GET /admin
    root to: "dashboards#show"
  end

  namespace :frontend, path: Archangel.config.frontend_path do
    scope Archangel.config.posts_path do
      # GET /posts
      # GET /posts/page/[PAGE]
      get "/(page/:page)", to: "posts#index", as: :posts

      # GET /posts/[YYYY]
      # GET /posts/[YYYY]/page/[PAGE]
      get "/:year(/page/:page)", to: "posts#index",
                                 as: :posts_year,
                                 constraints: { year: /\d{4}/ }

      # GET /posts/[YYYY]/[MM]
      # GET /posts/[YYYY]/[MM]/page/[PAGE]
      get "/:year/:month(/page/:page)", to: "posts#index",
                                        as: :posts_year_month,
                                        constraints: {
                                          year: /\d{4}/,
                                          month: /\d{2}/
                                        }

      # GET /posts/[YYYY]/[MM]/[SLUG]
      get "/:year/:month/:slug", to: "posts#show",
                                 as: :post,
                                 constraints: { year: /\d{4}/, month: /\d{2}/ }

      # GET /posts/category/[SLUG]
      # GET /posts/category/[SLUG]/page/[PAGE]
      get "/category/:slug(/page/:page)", to: "posts#category",
                                          as: :posts_category

      # GET /posts/tag/[SLUG]
      # GET /posts/tag/[SLUG]/page/[PAGE]
      get "/tag/:slug(/page/:page)", to: "posts#tag", as: :posts_tag
    end

    # GET /[PATH]
    get "*path", to: "pages#show", as: :page

    # GET /
    root to: "pages#show"
  end

  # GET /
  root to: "frontend/pages#show"
end
