class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  #layout "plain"

  def new
    set_return_to_after_authenticating_via_modal
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user

      respond_to do |format|
        format.html { redirect_to after_registration_url, notice: 'Successfully signed up' }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  private
    def user_params
      params.expect(user: %i[fullname phone_number email_address password terms_accepted privacy_policy_accepted])
    end
end
