# typed: strict
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ??? Doesn't seem to generate routes with the :id filter, even if it's on member.
  # resource :posts, param: :id, only: %i[index show] do
  #   get :rate, on: :member
  # end

  get "/", to: "root#home", as: "root"

  # SECTION Authorisation
  get "login", to: "sessions#new", as: "login"
  post "sessions/new", to: "sessions#new"
  # !SECTION

  # SECTION Posts
  get "posts/:id", to: "posts#show"
  get "posts/rate/:id", to: "posts#rate"
  # !SECTION
end
