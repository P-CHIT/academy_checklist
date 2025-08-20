Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks do
    member do
      patch :toggle
    end
  end

  get "brag" => "tasks#brag", as: :brag_quests

  get "up" => "rails/health#show", as: :rails_health_check

  match "*path", to: redirect("/"), via: :all
  match "*path/", to: redirect("/"), via: :all
end
