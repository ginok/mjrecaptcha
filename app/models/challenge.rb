class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Tokenable

  field :pai_positions, type: Array, default: []
  field :true_challenge_id, type: Moped::BSON::ObjectId

  def verify_answer(answers)
    true_challenge.collect?(answers[true_challenge_index])
  end

  def true_challenge
    @_true_challenge ||= PaiPosition.find(self.true_challenge_id)
  end

  def true_challenge_index
    index =  self.pai_positions.index(self.true_challenge_id.to_s)
    raise "can not find true challenge" if index.nil?
    index
  end

  class << self
    def generate_new
      challenge = Challenge.new
      true_challenge = get_identified_challenge
      challenge.pai_positions << true_challenge.to_param
      challenge.pai_positions << get_not_identified_challenge.to_param
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
