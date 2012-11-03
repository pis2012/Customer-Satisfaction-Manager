CSM::Application.routes.draw do

  ########### MY_PROJECT ROUTES ###########
  match "/my_projects" => "my_projects#index", :as => :my_projects

  # FEEDBACKS ROUTES
  resources :feedbacks, :only => [:show, :new, :create, :edit, :update, :destroy]
  match "/feedbacks/date_filter" => "feedbacks#date_filter", :as => :feedbacks_date_filter

  # COMMENTS ROUTES
  resources :comments, :only => [:create, :destroy]

  # MILESTONES ROUTES
  resources :milestones, :only => [:destroy, :create]

  scope "/my_projects" do
    # CHANGE PROFILE PROJECT
    match "/:project_id"                => "projects#change_profile_project", :as => :change_profile_project

    # CHANGE MOOD
    match "/change_mood/:new_status"    => "projects#change_mood",            :as => :change_mood

    # SHOW PROJECT DATA
    match "/:project_id/data/"          => "projects#show_project_data",      :as => :project_data

    # FEEDBACKS ROUTES
    match ":project_id/feedbacks"       => "feedbacks#project_feedbacks",     :as => :project_feedbacks
    match ":project_id/feedbacks/new/"  => "feedbacks#new",                   :as => :new_feedback

    # MILESTONES ROUTES
    match ":project_id/milestones"      => "milestones#project_milestones",   :as => :project_milestones
    match ":project_id/milestones/new/" => "milestones#new",                  :as => :new_milestone
  end
  #----------- MY_PROJECT ROUTES -----------#

  ############ PROFILE ROUTES ############
  match "profile" => "profiles#edit", :as => :edit_profile
  resources :profiles, :only  => [:update]
  #----------- PROFILE ROUTES -----------#

  ############ ADMIN ROUTES ############
  match "/users/name_filter" => "users#name_filter", :as => :users_name_filter



  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :passwords => "passwords"}
  scope "/admin" do
    #SUMMARY ROUTES
    match "/summary" => "activities#index", :as => :summary
    match "/summary/site_activities_filter" => "activities#activities_filter", :as => :activities_filter

    # USERS ROUTES
    resources :users
    resources :projects

    resources :forms, :only => [:index,:show,:new,:create,:destroy]
    match "/forms/show_data/:id" => "forms#show_data", :as => :forms_show_data
    match "/forms/show_full_data/:id" => "forms#show_full_data", :as => :forms_show_full_data
  end

  resources :clients, :only => [:new, :create, :update], :path => "/admin/clients"
  match "/admin/clients" => "clients#index", :as => :admin_clients
  match "/admin/client/:client_id" => "clients#show", :as => :clients_show
  match "/admin/client/edit/:client_id" => "clients#edit", :as => :clients_edit
  match "/admin/client/delete/:client_id" => "clients#destroy", :as => :clients_delete



  #match "/my_projects/change_mood" , to: "projects#change_mood"

  match "/admin" => "admin#index", :as => :admin
  match "/admin/reports" => "admin#show_reports", :as => :admin_reports
  #match "/admin/projects" => "admin#index", :as => :admin_projects
  match "/admin/forms" => "forms#index", :as => :admin_forms


  resources :projects, :only => [:index, :new, :create,:update , :edit,:destroy,:show] #:constraints => lambda { |request| request.env['warden'].user.admin? }
  match "/admin/projects" => "projects#index" , :as => :admin_projects

  match "/projects/name_filter" => "projects#name_filter", :as => :projects_name_filter
  match "/admin/projects/new" => "projects#new-project", :as => :new_project
  match "/admin/projects/:project_id" => "projects#show", :as => :projects_show
  match "/admin/projects/edit/:project_id" => "projects#edit", :as => :projects_edit
  match "/admin/projects/delete/:project_id" => "projects#destroy", :as => :projects_delete


  # MAILS ROUTES
  match "/my_projects/:project_id/change_mood/:new_status"  => "projects#change_any_project_mood",  :as => :change_any_project_mood

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
