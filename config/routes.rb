Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :trains, only: [:index, :show]
      get '/get_train_by_symbol/:symbol', to: "trains#get_train_by_symbol"
    end
  end

end
