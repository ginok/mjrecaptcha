class PaiChallenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Tokenable

  has_and_belongs_to_many :pai_positions, inverse_of: nil
  field :true_challenge_id, type: Moped::BSON::ObjectId

  class << self
    def generate_new
      challenge = PaiChallenge.new
      true_challenge = get_identified_challenge
      debugger
      challenge.pai_positions << true_challenge
      challenge.pai_positions << get_not_identified_challenge
      challenge.true_challenge_id = true_challenge.to_param
      challenge.save
      challenge
    end

    def get_identified_challenge
      PaiPosition.first
    end

    def get_not_identified_challenge
      PaiPosition.last
    end
  end
end
