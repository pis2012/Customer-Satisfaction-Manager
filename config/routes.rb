CSM::Application.routes.draw do

  resources :profiles, :only => [:update,:edit]

  resources :comments

  match "/feedbacks/project_feedbacks/:project_id" => "feedbacks#project_feedbacks", :as => :project_feedbacks
  match "/feedbacks/new/:project_id" => "feedbacks#new", :as => :new_feedback
  match "/feedbacks/date_filter" => "feedbacks#date_filter", :as => :feedbacks_date_filter
  resources :feedbacks



  match "profile" => "users#show"

  resources :moods

  match "/milestones/new/:project_id" => "milestones#new", :as => :new_milestone
  resources :milestones

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :clients

  match "/my_projects" , to: "projects#show_project_complete" , :as => :my_projects
  match "/my_projects/change_profile_project", to: "projects#change_profile_project"
  match "/projects/show_project_data/:project_id" => "projects#show_project_data", :as => :project_data
  match "/my_projects/change_mood", to: "projects#change_mood"

  match "/admin" => "admin#index", :as => :admin

  resources :projects


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  root :to => 'home#index'

end
