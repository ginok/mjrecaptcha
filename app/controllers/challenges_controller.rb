class ChallengesController < ApplicationController
  respond_to :json, :html

  def new
  end

  def create
    @challenge = Challenge.generate_new
    respond_with @challenge, location: @challenge
  end

  def show
    @challenge = Challenge.find(params[:id])
    respond_with @challenge
  end
end
