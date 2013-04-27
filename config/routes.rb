Mjrecaptcha::Application.routes.draw do
  resources :pai_positions
  resources :challenges, except: :index do
    collection do
      post :verify
    end
  end

  get "/" => "top#show"
  get "challenges" => "challenges#new_challenge"
  get "recaptcha" => "statics#recaptcha"
end
