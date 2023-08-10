Rails.application.routes.draw do
  root "events#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :events do
    resources :enrollments
  end
  resources :users
  get 'enrollments', to: 'enrollments#index'
end
