class PaiPositionsController < ApplicationController
  def index
    @pai_positions = PaiPosition.all
  end
end
