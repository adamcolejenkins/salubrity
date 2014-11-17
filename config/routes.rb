Rails.application.routes.draw do

  resources :devices

  constraints(Subdomain) do
    
    resources :teams, except: [:index, :show, :new], path_names: { new: 'get-started' }

    resources :surveys do
      resources :fields
    end

    resources :clinics
    resources :providers

    get '/install', to: redirect('/install/new')
    resource :install, only: [:new, :create, :edit, :update], as: 'installs'

    devise_for :users, :controllers => { :invitations => 'users/invitations', :registrations => 'users/registrations' }, :skip => [:sessions]
    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
      get "profile" => "users/registrations#edit"
      resources :users, except: [:show]
    end

    namespace :dashboard do
      get 'surveys' => 'survey#index'
      get 'surveys/:id/chart/:chart(/:field_id)' => 'survey#chart', as: :survey_chart

      get 'clinics' => 'clinic#index'
      get 'clinics/:id/chart/:chart(/:field_id)' => 'clinic#chart', as: :clinic_chart
      
      get 'providers' => 'provider#index'
      get 'providers/:id/chart/:chart(/:field_id)' => 'provider#chart', as: :provider_chart

      root to: redirect('/dashboard/surveys')
    end

    # get '/dashboard(/:resource)' => 'dashboard#index', as: 'dashboard', resource: 'survey'

    get '/', to: redirect('/dashboard/surveys')
    
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
