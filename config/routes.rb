Code::Application.routes.draw do
  resources :users,  except: [:edit, :show, :destroy, :update]
  resources :sessions, only: [:new, :create, :destroy]

  # Shallow nesting to ensure paths (URLs) are not filled with unnecessary information.
  resources :courses, except: [:edit, :update, :destroy, :show], shallow: true do
    resources :tracks, except: [:edit, :update, :destroy, :index, :create, :new] do
      resources :lessons, except: [:edit, :update, :destroy, :index, :create, :new, :show]
    end
  end

  root 'pages#home'

  match '/help',      to: 'pages#help',      via: 'get'
  match '/about',     to: 'pages#about',     via: 'get'
  match '/contact',   to: 'pages#contact',   via: 'get'
  match '/dashboard', to: 'users#dashboard', via: 'get'

  # Courses
  match '/courses/:permalink', to: 'courses#show',    via: 'get', as: 'custom_course'
  match '/courses/:permalink',        to: 'courses#destroy', via: 'delete'
  match '/courses/:permalink/edit',   to: 'courses#edit',    via: 'get', as: 'course_edit'
  match '/courses/:permalink',        to: 'courses#update',  via: 'put', as: 'course'
  match '/courses/:permalink',        to: 'courses#update',  via: 'patch'
  match '/courses/:permalink',        to: 'courses#update',  via: 'post'


  # Tracks
  match '/courses/:permalink/tracks/new', to: 'tracks#new',    via: 'get', as: 'new_course_track'
  match '/courses/:permalink/tracks',     to: 'tracks#create', via: 'patch'
  match '/courses/:permalink/tracks',     to: 'tracks#create', via: 'put'
  match '/courses/:permalink/tracks',     to: 'tracks#create', via: 'post'
  match '/courses/:permalink/tracks',     to: 'tracks#index',  via: 'get', as: 'tracks'

  # Short Tracks Permalinks
  match '/track/:permalink',      to: 'tracks#show',    via: 'get', as: 'custom_track'
  match '/track/:permalink/edit', to: 'tracks#edit',    via: 'get', as: 'edit_track'
  match '/tracks/:permalink',     to: 'tracks#update',  via: 'put'
  match '/tracks/:permalink',     to: 'tracks#update',  via: 'post'
  match '/tracks/:permalink',     to: 'tracks#update',  via: 'patch'
  match '/tracks/:permalink',     to: 'tracks#destroy', via: 'delete'

  # Lessons
  match '/tracks/:permalink/lessons/new', to: 'lessons#new',    via: 'get', as: 'new_track_lesson'
  match '/tracks/:permalink/lessons',     to: 'lessons#create', via: 'post'
  match '/tracks/:permalink/lessons',     to: 'lessons#create', via: 'put'
  match '/tracks/:permalink/lessons',     to: 'lessons#create', via: 'patch'
  match '/tracks/:permalink/lessons',     to: 'lessons#index',  via: 'get', as: 'lessons'

  # Short Lesson Permalinks
  match '/lesson/:permalink', to: 'lessons#show', via: 'get', as: 'custom_lesson'
  match '/lessons/:permalink', to: 'lessons#destroy', via: 'delete', as: 'delete_lesson'

  # Users
  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  match '/users/:permalink', to: 'users#update', via: 'put', as: 'user'
  match '/users/:permalink', to: 'users#update', via: 'patch'
  match '/users/:permalink', to: 'users#update', via: 'post'

  # All paths must be declared before this to ensure Rails does not think
  # it is a username for a user (:permalink)
  match '/:permalink',      to: 'users#destroy', via: 'delete', as: 'custom_delete_user'
  get   '/:permalink',      to: 'users#show',    as: 'custom_user'
  get   '/:permalink/edit', to: 'users#edit',    as: 'custom_edit_user'

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
