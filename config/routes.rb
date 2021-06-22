class Subdomain
  def self.matches?(request)
    request.domain.split('.').size > 1 && request.subdomain != 'publicv-staging' && request.subdomain.present?
  end
end

Rails.application.routes.draw do
  constraints(Subdomain) do
    get '/', to: 'cvs#show'
  end

  root 'home#index'
  # Static pages
  get 'legal/privacy-policy', to: 'legal#privacy'
  get 'legal/cookie-policy', to: 'legal#cookie'
  # TODO: get '/about', to: 'home#about'
  get 'legal/terms', to: 'legal#terms'

  get 'cv/:subdomain', to: 'cvs#show', as: 'cv_section'
  get 'cv/edit/:section', to: 'cvs#edit', as: 'edit_cv_section'
  put 'cv/download', to: 'cvs#download'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :accounts, only: :destroy
  resource :cv, except: %i[new edit create destroy show] do
    resources :educations, except: %i[index show] do
      post :update_positions, on: :collection
    end
    resources :experiences, except: %i[index show] do
      post :update_positions, on: :collection
    end
    resources :languages, except: %i[index show]
  end
  resources :cvs, only: [:show] do
    get '/print', to: 'cvs/printings#show', as: :print
  end
  resources :contacts, only: %i[new create]
  resources :searches, only: %i[create show]
  resolve('Cv') { [:cv] }

  namespace :users do
    resources :preferences, only: [:index] do
      put :update, on: :collection
    end
  end
  namespace :admins do
    resources :newsletters, except: %i[show destroy] do
      get :preferences, on: :collection
      resources :submittal, only: [:create]
    end
  end
  resources :preferences, only: %i[show update] do
    get :unsubscribe, on: :member
  end

  resources :attachments, only: [:create]
  # resources :locations, except: %i[index show]
end
