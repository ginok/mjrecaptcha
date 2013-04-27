module Concerns::ApiUser
  extend ActiveSupport::Concern

  included do
    before_create :set_api_credentials

    field :app_id, type: String
    field :app_secret, type: String
  end

  def token(n=20)
    SecureRandom.urlsafe_base64(n)
  end

  def set_api_credentials
    self.app_id = token(20)
    self.app_secret = token(40)
  end
end
