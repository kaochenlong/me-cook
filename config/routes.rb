Rails.application.routes.draw do
  devise_for :users

  # resources :users, only: [] do
  #   collection do
  #     get :favorites
  #   end
  # end

  root "recipes#index"
  resources :recipes do
    collection do
      get :my     # /recipes/my  my_recipes_path
    end
  end
end


