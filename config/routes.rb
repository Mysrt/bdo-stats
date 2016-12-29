Rails.application.routes.draw do
  devise_for :users

  resources :users
  resources :guilds

  get 'inv/*invite_hash', to: 'guild_memberships#create'

  root to: 'users#show'
end
