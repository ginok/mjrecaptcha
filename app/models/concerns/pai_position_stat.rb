module Concerns::PaiPositionStat
  extend ActiveSupport::Concern

  included do
    field :challenge_times, type: Integer, default: 0
    field :answers, type: Hash, default: {}
  end

  def store_answer!(answer)
    self.challenge_times += 1
    self.answers[answer] = (self.answers[answer] || 0) + 1
    save
  end

  def top(n)
    self.ranking.first(n)
  end

  def ranking
    self.answers.sort{|a,b| b[1] <=> a[1]}
  end
end
