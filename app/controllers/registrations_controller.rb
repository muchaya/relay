class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  #layout "plain"

  def new
    user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      start_new_session_for user

      respond_to do |format|
        format.html { redirect_to after_authentication_url, notice: 'Successfully signed up' }
      end
    else
      render :new
    end
  end

  def user_params
    params.expect(user: %i[fullname phone_number email_address password terms_accepted privacy_policy_accepted])
  end
end
