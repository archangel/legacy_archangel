Archangel::Engine.routes.draw do
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

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

  namespace :admin do
    resources :pages, concerns: [:paginatable]
    resources :users, concerns: [:paginatable]

    resource :profile, except: [:new, :create]
    resource :site, only: [:show, :edit, :update]

    root to: "dashboards#show"
  end

  get "*path", to: "pages#show", as: :page

  root to: "pages#show"
end
