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
  end

  root :to => 'home#index'

  # get '/dashboard' => 'templates#index'

  get '/surveys' => 'templates#index'
  get '/survey/:id' => 'templates#index'
  get '/survey/create' => 'templates#index'

  get '/survey/:id/build' => 'templates#index', as: 'surveys_build'
  get '/survey/:id/design' => 'templates#index', as: 'surveys_design'
  get '/survey/:id/configure' => 'templates#index', as: 'surveys_configure'
  get '/survey/:id/analyze' => 'templates#index', as: 'surveys_analyze'
  
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
