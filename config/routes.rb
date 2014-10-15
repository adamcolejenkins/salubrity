Rails.application.routes.draw do

  get 'frontend/index'

  devise_for :users

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      resource :session, only: [:create, :destroy]
    end
    resources :surveys do
      resources :fields do
        resources :field_choices
      end
    end
    resources :clinics do
      resources :providers
    end
    get 's3/token'
  end

  root :to => 'home#index'

  # get '/dashboard' => 'angular#index'

  get '/surveys' => 'angular#index'
  get '/surveys/:id' => 'angular#index'
  get '/surveys/new' => 'angular#index', as: 'new_survey'

  get '/surveys/:id/build' => 'angular#index', as: 'surveys_build'
  get '/surveys/:id/design' => 'angular#index', as: 'surveys_design'
  get '/surveys/:id/configure' => 'angular#index', as: 'surveys_configure'
  get '/surveys/:id/analyze' => 'angular#index', as: 'surveys_analyze'

  get '/clinics' => 'angular#index'
  get '/clinics/:id' => 'angular#index'
  get '/clinics/:id/providers' => 'angular#index'
  get '/clinics/:id/design' => 'angular#index'
  get '/clinics/:id/settings' => 'angular#index'

  # get '/surveys/:survey_id/fields/:id' => 'angular#index'
  # get '/surveys/:survey_id/fields/:field_id/field_choices/:id' => 'angular#index'

  # get '/reports' => 'angular#index'
  # get '/reports/:id' => 'angular#index'
  # get '/reports/create' => 'angular#index'
  # get '/reports/:id/edit' => 'angular#index'

  # get '/users' => 'angular#index'
  # get '/users/invite' => 'angular#index'

  get '/templates/:path.html' => 'angular#template', :constraints => { :path => /.+/  }

  get '/kiosk' => 'angular#index'
  
  get '/kiosk/:guid' => 'kiosk#show', constraints: { guid: /[a-z\-]+/ }
  post '/kiosk/:guid/create' => 'kiosk#create', constraints: { guid: /[a-z\-]+/ }, as: 'responses'
end
