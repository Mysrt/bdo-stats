Rails.application.routes.draw do
  devise_for :users

  resources :users do
    member do
      get :edit_user_settings
    end
  end
  resources :guilds
  resources :changelogs
  resources :guild_memberships do
    member do
      patch :accept_invite
    end
  end

  get '/', to: 'home#index'

  get 'inv/*invite_hash', to: 'guild_memberships#create'

  root to: 'users#show'
end
