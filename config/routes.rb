Rails.application.routes.draw do
  namespace :admin do
  get 'redeem_requests/index'
  end

  namespace :admin do
  get 'reports/items'
  end

  namespace :admin do
  get 'reports/users'
  end

  namespace :admin do
  get 'notifications/index'
  end

  # devise_for :users
  root 'invitations#landing'
  # get "homepage" => "home#index", :as => "homepage"
  # namespace url for admin
  namespace 'admin' do
    resources :users do
      collection do
        post 'filter_user'
        get 'filter_user'
        get 'option_user'
      end
    end
    resources :payments
    resources :items do
      collection do
        post 'filter_item'
        get 'option_item'
      end
    end
    resources :invitations do
      collection do
        post 'send_mail'
        post 'filter_invite'
        get 'option_invite'
        delete 'destroy_multiple'
        get "sort_data"
      end
    end
    resources :item_categories
    resources :orders do
      collection do
        post 'filter_order'
        get 'filter_order'
        get 'option_order'
      end
    end
    resources :images
    resources :notifications
    resources :reports do
      collection do
        post 'filter_user'
        get 'option_user'
        post 'filter_item'
        get 'option_item'
      end
      member do
        get 'edit_item'
        get 'edit_user'
        put 'update_item'
        put 'update_user'
        get 'user_mail'
        get 'item_mail'
        delete 'delete_user'
        delete 'delete_item'
      end
    end
    resources :redeem_requests do
      collection do
        post 'filter_redeem'
        get 'option_redeem'
      end
    end
    get 'index' => 'admins#index'
    get 'logout' => 'devise/sessions#destroy'
    get "items/users/:id" => "items#user_items"
    get "orders/users/:id" => "orders#user_orders", as: :user_order
    get ":id/:follow_type" => "users#index", as: :user_follow
  end

  devise_for :admins, :path => '', :path_names => {:sign_in => 'admin'}, :controllers => {:sessions => "admin/sessions", :registrations => "admin/registrations", :passwords => "admin/passwords"}
  devise_for :users, path: "", path_names: { sign_in: 'login', sign_out: 'logout'}, :skip => :registrations
  resources :invitations do
    collection do
      post 'mail_invite'
      get 'invite_username'
      get "invited_username"
      get 'valid_user'
    end
  end
  put 'invitation_username/:id' => "invitations#invitation_username", :as => :invitation_username
  get "invite_friend" => "invitations#invite_friend"
  get "invite_friend/:id" => "invitations#invite_friend"
  get "reset_password" => "home#reset_password", :as => :reset_password
  put "update_password/:moch" => "home#update_password", :as => :update_password
  get "privacy" => "invitations#privacy"
  get "terms" => "invitations#terms"
  get "/:permalink",
    permalink: /[a-zA-Z0-9\-_\.]+?/,
    format: /html/,
    to: "home#show"

  get "/:permalink/:item_permalink",
    permalink: /[a-zA-Z0-9\-_\.]+?/,
    item_permalink: /[a-zA-Z0-9\-_\.]+?/,
    format: /html/,
    to: "home#detail"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
