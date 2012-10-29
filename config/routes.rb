CSM::Application.routes.draw do

 # Elrte.routes(self)

  resources :profiles, :only => [:update,:edit]

  resources :comments

  match "/feedbacks/project_feedbacks/:project_id" => "feedbacks#project_feedbacks", :as => :project_feedbacks
  match "/feedbacks/new/:project_id" => "feedbacks#new", :as => :new_feedback
  match "/feedbacks/date_filter" => "feedbacks#date_filter", :as => :feedbacks_date_filter
  resources :feedbacks



  match "profile" => "users#show"

  resources :moods

  match "/milestones/project_milestones/:project_id" => "milestones#project_milestones", :as => :project_milestones
  match "/milestones/new/:project_id" => "milestones#new", :as => :new_milestone
  resources :milestones

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :passwords => "passwords"}

  resources :clients , :only => [:index, :new, :create]
  match "/admin/clients" => "clients#index" , :as => :admin_clients
  match "/admin/client/:client_id" => "clients#show", :as => :clients_show

  match "/my_projects" , to: "my_projects#index" , :as => :my_projects
  match "/my_projects/change_profile_project", to: "projects#change_profile_project", :as => :change_profile_project
  match "/projects/show_project_data/:project_id" => "projects#show_project_data", :as => :project_data
  match "/projects/change_mood/:new_status" => "projects#change_mood", :as => :change_mood

  #match "/my_projects/change_mood" , to: "projects#change_mood"

  match "/admin" => "admin#index", :as => :admin
  match "/admin/reports" => "admin#show_reports", :as => :admin_reports
  match "/admin/forms" => "forms#index", :as => :admin_forms


  resources :projects, :constraints => lambda { |request| request.env['warden'].user.admin? }

  resources :forms, :only => [:index, :new, :create]
  match "/forms/show_data/:form_id" => "forms#show_data", :as => :forms_show_data
  match "/forms/show_full_data/:form_id" => "forms#show_full_data", :as => :forms_show_full_data
  match "/forms/show/:form_id" => "forms#show", :as => :forms_show
  #resources :forms, :only => [:index, :new]

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
