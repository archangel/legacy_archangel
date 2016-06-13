Archangel::Engine.routes.draw do
  # Pagination
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  # Backend comments
  concern :admin_commentable do
    resources :comments,
              except: [:create, :new, :show],
              concerns: [:paginatable]
  end

  # Frontend comments
  concern :frontend_commentable do
    resources :comments, except: [:delete, :show]
  end

  # GET    /login
  # POST   /login
  # DELETE /logout
  # POST   /password
  # GET    /password/new
  # GET    /password/edit
  # PATCH  /password
  # PUT    /password
  # GET    /cancel
  # POST   /
  # GET    /register
  # GET    /edit
  # PATCH  /
  # PUT    /
  # DELETE /
  # POST   /verification
  # GET    /verification/new
  # GET    /verification
  # POST   /unlock
  # GET    /unlock/new
  # GET    /unlock
  # GET    /invitation/accept
  # GET    /invitation/remove
  # POST   /invitation
  # GET    /invitation/new
  # PATCH  /invitation
  # PUT    /invitation
  devise_for :users,
             module: :devise,
             class_name: "Archangel::User",
             path: "",
             skip: [:omniauth_callbacks],
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               sign_up: "register",
               password: "password",
               confirmation: "verification",
               unlock: "unlock"
             }

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
    resources :categories

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

    # GET    /admin/posts
    # GET    /admin/posts/page/[PAGE]
    # GET    /admin/posts
    # POST   /admin/posts
    # GET    /admin/posts/new
    # GET    /admin/posts/[ID]/edit
    # GET    /admin/posts/[ID]
    # PATCH  /admin/posts/[ID]
    # PUT    /admin/posts/[ID]
    # DELETE /admin/posts/[ID]
    # GET    /admin/posts/[POST_ID]/comments
    # GET    /admin/posts/[POST_ID]/comments/pages/[PAGE]
    # GET    /admin/posts/[POST_ID]/comments/[ID]/edit
    # PATCH  /admin/posts/[POST_ID]/comments/[ID]
    # PUT    /admin/posts/[POST_ID]/comments/[ID]
    # DELETE /admin/posts/[POST_ID]/comments/[ID]
    resources :posts, concerns: [:admin_commentable]

    # GET    /admin/profile/edit
    # GET    /admin/profile
    # PATCH  /admin/profile
    # PUT    /admin/profile
    # DELETE /admin/profile
    # POST   /admin/profile/retoken
    resource :profile, except: [:new, :create] do
      member do
        post :retoken
      end
    end

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
    resources :tags, concerns: [:paginatable]

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
    # POST   /admin/users/[USERNAME]/retoken
    resources :users, concerns: [:paginatable] do
      member do
        post :retoken
      end
    end

    # GET /admin
    root to: "dashboards#show"
  end

  # GET    /posts
  # GET    /posts/page/[PAGE]
  # GET    /posts/[YEAR]
  # GET    /posts/[YEAR]/page/[PAGE]
  # GET    /posts/[YEAR]/[MONTH]
  # GET    /posts/[YEAR]/[MONTH]/page/[PAGE]
  # GET    /posts/[YEAR]/[MONTH]/[SLUG]
  # GET    /posts/[YEAR]/[MONTH]/[SLUG]/comments
  # POST   /posts/[YEAR]/[MONTH]/[SLUG]/comments
  # GET    /posts/[YEAR]/[MONTH]/[SLUG]/comments/new
  # GET    /posts/[YEAR]/[MONTH]/[SLUG]/comments/[ID]/edit
  # PATCH  /posts/[YEAR]/[MONTH]/[SLUG]/comments/[ID]
  # PUT    /posts/[YEAR]/[MONTH]/[SLUG]/comments/[ID]
  # DELETE /posts/[YEAR]/[MONTH]/[SLUG]/comments/[ID]
  resources :posts, path: "posts",
                    only: :index,
                    param: :year,
                    concerns: [:paginatable],
                    constraints: { year: /\d{4}/ } do
    resources :year, path: "",
                     controller: :posts,
                     only: :index,
                     param: :month,
                     concerns: [:paginatable],
                     constraints: { month: /[01]?\d/ },
                     as: :year do
      resources :month, path: "",
                        controller: :posts,
                        only: :index,
                        param: :id,
                        concerns: [:paginatable],
                        as: :month do
        resource :post, path: "",
                        controller: :posts,
                        only: :show,
                        concerns: [:frontend_commentable],
                        param: :id
      end
    end
  end

  # GET /[PATH]
  get "*path", to: "pages#show", as: :page

  # GET /
  root to: "pages#show"
end
