class PaiPosition
  include Mongoid::Document
  include Mongoid::Timestamps

  field :image_url, type: String
  field :x, type: Integer
  field :y, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :identified, type: Boolean, default: false
  field :initial_probability, type: Float
  field :initial_pai_type, type: String

  def collect?(answer)
    self.initial_pai_type == answer
  end
end
