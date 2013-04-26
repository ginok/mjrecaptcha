Mjrecaptcha::Application.routes.draw do
  resources :pai_positions
  resources :challenges, except: :index do
    collection do
      get :verify
    end
  end

  get "challenges" => "challenges#new_challenge"
  get "recaptcha" => "statics#recaptcha"
end
