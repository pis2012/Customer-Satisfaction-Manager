CSM::Application.routes.draw do

  # ============== [ HOME ROUTES ] ================= #
  match "/home/csm_information" => "home#csm_information",  :as => :csm_information

  # ============== [ MY_PROJECTS ROUTES ] ========== #
  match "/my_projects"          => "my_projects#index",     :as => :my_projects

  # FEEDBACKS ROUTES
  resources :feedbacks, :only   => [:show, :new, :create, :edit, :update, :destroy]

  # COMMENTS ROUTES
  resources :comments, :only    => [:create, :destroy]

  # MILESTONES ROUTES
  resources :milestones, :only  => [:destroy, :create]

  scope "/my_projects" do
    # CHANGE PROFILE PROJECT
    match "/:project_id" => "projects#change_profile_project",                  :as => :change_profile_project

    # CHANGE MOOD
    match "/:project_id/change_mood/:new_status" => "projects#change_mood",     :as => :change_mood

    # SHOW PROJECT DATA
    match "/:project_id/data/"                => "projects#show_project_data",  :as => :project_data

    # FEEDBACKS ROUTES
    match ":project_id/feedbacks"             => "feedbacks#project_feedbacks", :as => :project_feedbacks
    match ":project_id/feedbacks/new/"        => "feedbacks#new",               :as => :new_feedback
    match ":project_id/feedbacks/date_filter" => "feedbacks#date_filter",       :as => :feedbacks_date_filter

    # MILESTONES ROUTES
    match ":project_id/milestones"      => "milestones#project_milestones",     :as => :project_milestones
    match ":project_id/milestones/new/" => "milestones#new",                    :as => :new_milestone
  end

  # ============== [ PROFILE ROUTES ] ============== #

  match "profile" => "profiles#edit", :as => :edit_profile
  resources :profiles, :only  => [:update]


  # ============== [ ADMIN ROUTES ] ================ #
  match "/admin" => "admin#index", :as => :admin

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :passwords => "passwords"}
  scope "/admin" do
    # SUMMARY ROUTES
    match "/summary" => "activities#index", :as => :summary
    match "/summary/site_activities_filter" => "activities#activities_filter", :as => :activities_filter

    # REPORTS ROUTES
    match "/admin/reports"        => "admin#show_reports",    :as => :admin_reports

    # PROJECT ROUTES
    match "/projects/text_filter" => "projects#text_filter",  :as => :projects_text_filter
    resources :projects, :only => [:index, :new, :create, :update, :edit, :destroy]

    # USERS ROUTES
    match "/users/name_filter"    => "users#name_filter",     :as => :users_name_filter
    resources :users

    # CLIENTS ROUTES
    match "/projects/name_filter" => "clients#name_filter",   :as => :clients_name_filter
    resources :clients

    # FORMS ROUTES
    resources :forms, :only => [:index,:show,:new,:create,:destroy]
    match "/forms/show_data/:id"      => "forms#show_data",      :as => :forms_show_data
    match "/forms/show_data_all/:id"  => "forms#show_data_all",  :as => :forms_show_data_all
    match "/forms/show_full_data/:id" => "forms#show_full_data", :as => :forms_show_full_data

    # EMAILS ROUTES
    match "/emails" => "admin#emails_config", :as => :emails_config
    match "/csm_property/edit/:id" => "admin#property_update", :as => :property_update
  end

  match "/home" => "home#language_change", :as => :home_language_change
  resource :home


  # ============== [ EMAIL ROUTES ] ================ #
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
