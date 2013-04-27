Mjrecaptcha::Application.routes.draw do
  resources :pai_positions

  resources :challenges, except: :index do
    collection do
      post :verify
    end
  end

  get "challenges" => "challenges#new_challenge"
  get "recaptcha" => "statics#recaptcha"

  namespace :admin do
    resources :pai_positions do
      member do
        put :identify
      end
    end
  end
end
