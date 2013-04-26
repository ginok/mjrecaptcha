module Concerns::Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token

    field :token, type: String

    validates :token, uniqueness: true
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64(20)
  end
end
