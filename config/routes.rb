Rails.application.routes.draw do

  constraints(Subdomain) do

    scope :config do
      resources :teams
      resources :surveys do
        resources :fields do
          resources :field_choices
        end
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      resources :clinics, except: [:show] do
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      resources :providers, except: [:show] do
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      resources :devices, except: [:show] do
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      resources :locations, except: [:show] do
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      resources :services, except: [:show] do
        collection do
          get 'archived'
        end
        member do
          get 'restore'
          delete 'archive'
        end
      end
      root to: redirect('/config/surveys'), as: 'config_root'
    end

    scope :chart do
      get 'recent_responses_chart' => 'responses#recent_responses_chart'
      get 'clinic_usage_chart' => 'responses#clinic_usage_chart'
      get 'multiple_choice_chart' => 'responses#multiple_choice_chart'
    end
    get 'dashboard' => 'responses#index'
    post 'dashboard' => 'responses#index'

    # get '/install', to: redirect('/install/new')
    # resource :install, only: [:new, :create, :edit], as: 'installs'
    # post 'install/:id' => 'installs#update', as: 'device'

    devise_for :users, 
      controllers: { 
        :invitations => 'users/invitations',
        :registrations => 'users/registrations'
      },
      skip: [:sessions]

    as :user do
      get 'login' => 'devise/sessions#new', :as => :new_user_session
      post 'login' => 'devise/sessions#create', :as => :user_session
      delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
      get "profile" => "users/registrations#edit"
      resources :users, except: [:show]
    end
    
    get "/kiosk/:survey_guid/:clinic_guid" => 'kiosk#new', constraints: { survey_guid: /[a-z\-]+/, clinic_guid: /[a-z\-]+/ }, as: "new_response"
    post "/kiosk/:survey_guid/:clinic_guid" => 'kiosk#create', constraints: { survey_guid: /[a-z\-]+/, clinic_guid: /[a-z\-]+/ }, as: "responses"

    get '/', to: redirect('/dashboard')
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
