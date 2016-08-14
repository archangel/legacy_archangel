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
             path: "",
             path_prefix: Archangel.configuration.auth_path,
             skip: [:omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "register",
               password: "password",
               confirmation: "verification",
               unlock: "unlock"
             }
  get Archangel.configuration.auth_path,
      to: redirect("#{Archangel.configuration.auth_path}/login")

  namespace :admin, path: Archangel.configuration.admin_path do
    # GET    /admin/categories
    # GET    /admin/categories/page/[PAGE]
    # GET    /admin/categories
    # POST   /admin/categories
    # GET    /admin/categories/new
    # GET    /admin/categories/[ID]/edit
    # GET    /admin/categories/[ID]
    # PATCH  /admin/categories/[ID]
    # PUT    /admin/categories/[ID]
    # DELETE /admin/categories/[ID]
    resources :categories, concerns: [:paginatable] do
      collection do
        get "autocomplete"
      end
    end

    # GET    /admin/pages
    # GET    /admin/pages/page/[PAGE]
    # GET    /admin/pages
    # POST   /admin/pages
    # GET    /admin/pages/new
    # GET    /admin/pages/[ID]/edit
    # GET    /admin/pages/[ID]
    # PATCH  /admin/pages/[ID]
    # PUT    /admin/pages/[ID]
    # DELETE /admin/pages/[ID]
    resources :pages, concerns: [:paginatable]

    # GET    /admin/profile/edit
    # GET    /admin/profile
    # PATCH  /admin/profile
    # PUT    /admin/profile
    # DELETE /admin/profile
    resource :profile, except: [:new, :create]

    # GET   /admin/site/edit
    # GET   /admin/site
    # PATCH /admin/site
    # PUT   /admin/site
    resource :site, only: [:show, :edit, :update]

    # GET    /admin/tags
    # GET    /admin/tags/page/[PAGE]
    # GET    /admin/tags
    # POST   /admin/tags
    # GET    /admin/tags/new
    # GET    /admin/tags/[ID]/edit
    # GET    /admin/tags/[ID]
    # PATCH  /admin/tags/[ID]
    # PUT    /admin/tags/[ID]
    # DELETE /admin/tags/[ID]
    resources :tags, concerns: [:paginatable] do
      collection do
        get "autocomplete"
      end
    end

    # GET    /admin/users
    # GET    /admin/users/page/[PAGE]
    # GET    /admin/users
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

  # GET /[PATH]
  get "*path", to: "pages#show", as: :page

  # GET /
  root to: "pages#show"
end
