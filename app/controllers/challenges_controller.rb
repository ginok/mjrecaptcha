class ChallengesController < ApplicationController
  respond_to :json, :html

  def new
  end

  def new_challenge
    user = User.find_by(app_id: params[:app_id])
    @challenge = Challenge.generate_new(user)
    respond_with @challenge, location: @challenge
  end

  def verify
    user = User.find_by(app_secret: params[:privatekey])
    challenge = Challenge.find_by(token: params[:challenge])

    if challenge.valid_user?(user)
      if challenge.verify_answer(params[:response].split(" "))
        render text: "true\nsuccess"
      else
        render text: "false\nincorrect-captcha-sol"
      end
    else
      render text: "false\nincorrect-user"
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    respond_with @challenge
  end
end
