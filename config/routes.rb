Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :guilds
  resources :guild_memberships do
    member do
      patch :accept_invite
    end
  end


  get 'inv/*invite_hash', to: 'guild_memberships#create'

  root to: 'users#show'
end
