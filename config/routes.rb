Mjrecaptcha::Application.routes.draw do
  resources :pai_positions
  resources :challenges do
    collection do
      get :verify
    end
  end

  get "recaptcha" => "statics#recaptcha"
end
