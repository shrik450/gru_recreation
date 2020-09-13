# typed: strict
Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # ??? Doesn't seem to generate routes with the :id filter, even if it's on member.
  # resource :posts, param: :id, only: %i[index show] do
  #   get :rate, on: :member
  # end

  get "posts/:id", to: "posts#show"
  get "posts/rate/:id", to: "posts#rate"
end
