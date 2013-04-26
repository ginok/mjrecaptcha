class ChallengesController < ApplicationController
  respond_to :json, :html

  def new
  end

  def new_challenge
    @challenge = Challenge.generate_new
    respond_with @challenge, location: @challenge
  end

  def verify
    challenge = Challenge.find_by(token: params[:challenge])
    if challenge.verify_answer(params[:after].split(" "))
      render text: "true\nsuccess"
    else
      render text: "false\nbad:answer"
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    respond_with @challenge
  end
end
