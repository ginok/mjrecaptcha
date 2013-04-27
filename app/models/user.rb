class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Signap::User
  include Signap::Confirmable
  include Signap::Omniauthable
  include Concerns::ApiUser

  field :domain, type: String

  def self.construct(params={})
    User.new(params)
  end
end
