class StaticsController < ApplicationController
  respond_to :js

  def recaptcha
    @pubkey = request[:k]
  end
end
