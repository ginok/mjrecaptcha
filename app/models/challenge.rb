class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::Tokenable

  belongs_to :user
  field :pai_positions, type: Array, default: []
  field :true_challenge_id, type: Moped::BSON::ObjectId

  def verify_answer(answers)
    answers.each_with_index do |answer, i|
      self.pai_position(i).store_answer!(answer)
    end
    true_challenge.collect?(answers[true_challenge_index])
  end

  def pai_position(index)
    PaiPosition.find(self.pai_positions[index])
  end

  def true_challenge
    @_true_challenge ||= PaiPosition.find(self.true_challenge_id)
  end

  def true_challenge_index
    index =  self.pai_positions.index(self.true_challenge_id.to_s)
    raise "can not find true challenge" if index.nil?
    index
  end

  def valid_user?(user)
    self.user == user
  end

  class << self
    def generate_new(user)
      challenge = Challenge.new
      challenge.user = user
      true_challenge = get_identified_challenge


      challenge.pai_positions << true_challenge.to_param
      challenge.pai_positions << get_not_identified_challenge.to_param
      challenge.pai_positions.shuffle!
      challenge.true_challenge_id = true_challenge.to_param
      challenge.save
      challenge
    end

    def get_identified_challenge
      count = PaiPosition.identified.count
      if count > 0
        PaiPosition.identified.skip(rand(count)).first
      else
        PaiPosition.max_probability
      end
    end

    def get_not_identified_challenge
      PaiPosition.not_identified.skip(rand(PaiPosition.not_identified.count)).first
    end
  end
end
