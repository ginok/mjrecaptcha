class PaiPosition
  include Mongoid::Document
  include Mongoid::Timestamps
  include Concerns::PaiPositionStat

  field :image_url, type: String
  field :x, type: Integer
  field :y, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :identified, type: Boolean, default: false
  field :initial_probability, type: Float
  field :initial_pai_type, type: String
  field :original_created_at, type: DateTime

  scope :identified, -> { where(identified: true) }
  scope :not_identified, -> { where(identified: false) }

  def collect?(answer)
    self.initial_pai_type == answer
  end

  def identify!
    self.identified = true; save
  end

  class << self
    def max_probability
      self.max do |a,b|
        a.initial_probability <=> b.initial_probability 
      end
    end
  end
end
