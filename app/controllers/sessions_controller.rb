class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create destroy ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    set_return_to_after_authenticating_via_modal
  end

  def create
    if user = User.authenticate_by(params.permit(:phone_number, :password))
      start_new_session_for user

      redirect_to after_login_url, notice: "Successfully logged in"
    else
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    terminate_session
    redirect_to root_path, notice: "Successfully logged out"
  end
end
