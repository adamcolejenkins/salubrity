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

  # get '/dashboard' => 'templates#index'

  get '/surveys' => 'templates#index'
  get '/surveys/:id' => 'templates#index'
  get '/surveys/new' => 'templates#index', as: 'new_survey'

  get '/surveys/:id/build' => 'templates#index', as: 'surveys_build'
  get '/surveys/:id/design' => 'templates#index', as: 'surveys_design'
  get '/surveys/:id/configure' => 'templates#index', as: 'surveys_configure'
  get '/surveys/:id/analyze' => 'templates#index', as: 'surveys_analyze'

  get '/clinics' => 'templates#index'
  get '/clinics/:id' => 'templates#index'
  get '/clinics/:id/providers' => 'templates#index'
  get '/clinics/:id/design' => 'templates#index'
  get '/clinics/:id/settings' => 'templates#index'

  # get '/surveys/:survey_id/fields/:id' => 'templates#index'
  # get '/surveys/:survey_id/fields/:field_id/field_choices/:id' => 'templates#index'

  # get '/reports' => 'templates#index'
  # get '/reports/:id' => 'templates#index'
  # get '/reports/create' => 'templates#index'
  # get '/reports/:id/edit' => 'templates#index'

  # get '/users' => 'templates#index'
  # get '/users/invite' => 'templates#index'

  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }

  get ':guid' => 'response#index', constraints: { guid: /[a-z\-]+/ }
end
