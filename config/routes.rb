Rails.application.routes.draw do

  constraints(Subdomain) do
    
    resources :teams, except: [:index, :show, :new], path_names: { new: 'get-started' }

    resources :surveys do
      member do 
        get 'chart/:type(/field/:field_id)' => 'surveys#chart', as: :chart
      end
      resources :fields
    end

    resources :clinics do
      member do 
        get 'chart/:type(/field/:field_id)' => 'clinics#chart', as: :chart
      end
      resources :devices
    end

    resources :providers do
      member do 
        get 'chart/:type(/field/:field_id)' => 'providers#chart', as: :chart
      end
    end

    get '/install', to: redirect('/install/new')
    resource :install, only: [:new, :create, :edit], as: 'installs'
    post 'install/:id' => 'installs#update', as: 'device'

    devise_for :users, :controllers => { :invitations => 'users/invitations', :registrations => 'users/registrations' }, :skip => [:sessions]
    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
      get "profile" => "users/registrations#edit"
      resources :users, except: [:show]
    end

    get '/', to: redirect('/surveys')
    
    get "/kiosk/:survey_guid/:clinic_guid" => 'kiosk#new', constraints: { survey_guid: /[a-z\-]+/, clinic_guid: /[a-z\-]+/ }, as: "new_response"
    post "/kiosk/:survey_guid/:clinic_guid" => 'kiosk#create', constraints: { survey_guid: /[a-z\-]+/, clinic_guid: /[a-z\-]+/ }, as: "responses"
  end

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      resource :session, only: [:create, :destroy]
    end
    resources :surveys do
      resources :fields do
        resources :field_choices
      end
      resources :clinics do
        resources :providers
      end
    end
    get 's3/token'
  end

  get 'get-started' => 'teams#new', constraints: {subdomain: /(www)?/x}
  post 'get-started' => 'teams#create', constraints: {subdomain: /(www)?/x}
  
  root :to => 'home#index', constraints: {subdomain: /(www)?/x}

  get '/templates/:path.html' => 'angular#template', :constraints => { :path => /.+/  }
end
