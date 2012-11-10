Petcuida::Application.routes.draw do

  # get 'static_pages/home'
  # 
  # get 'static_pages/vets_home'

  mount_roboto

  # authenticated :user do
  #   root :to => 'home#index'
  # end

  devise_scope :owner do
    root :to => 'devise/registrations#new'
    # match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
    get 'thanks' => 'devise/registrations#thanks'
  end

  devise_for :owners, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' }
  
  devise_for :vets, :controllers => { :registrations => 'registrations', :confirmations => 'confirmations' }
  # 
  # match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  # 
  # resources :users, :only => [:show, :index] do
  #   get 'invite', :on => :member
  # end
  
  match 'vets/home' => 'static_pages#vets_home'
end