Rails.application.routes.draw do

  devise_for :users, :controllers => { registration: 'registrations' }
  root 'games#index'
  resources :games do
    resources :reviews
  end


end
