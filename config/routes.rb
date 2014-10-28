Rails.application.routes.draw do

  constraints(Subdomain) do
    
    resources :teams, except: [:index, :show, :new], path_names: { new: 'get-started' }

    resources :surveys do
      resources :fields, only: [:index]
      resources :clinics do
        resources :providers
      end
    end

    devise_for :users, :controllers => { :invitations => 'users/invitations', :registrations => 'users/registrations' }
    devise_scope :user do
      get "login" => "devise/sessions#new"
      get "profile" => "users/registrations#edit"
      resources :users, except: [:show]
    end

    get '/' => 'dashboard#index', as: 'dashboard'
    
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
  post 'get-started' => 'teams#create', constraints: {subdomain: /(www)?/x}, as: 'teams'
  
  root :to => 'home#index', constraints: {subdomain: /(www)?/x}

  # get '/templates/:path.html' => 'angular#template', :constraints => { :path => /.+/  }
end
