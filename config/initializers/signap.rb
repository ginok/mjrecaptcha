Signap.configure do |config|
  config.user_model = User
  config.redirect_url_after_login = '/user'
  config.additional_attributes = [:password, :domain]
end
