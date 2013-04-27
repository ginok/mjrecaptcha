class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Signap::User
  include Signap::Confirmable
  include Signap::Omniauthable

  field :domain, type: String

  def self.construct(params={})
    User.new(params)
  end
end
