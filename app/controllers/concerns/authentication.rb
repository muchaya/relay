module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      if session = find_session_by_cookie
        set_current_session session
      end
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id])
    end

    def request_authentication
      session[:return_to_after_authenticating] = request.url
      redirect_to new_session_path
    end

    def after_registration_url
      session.delete(:return_to_after_authenticating) || onboardings_path
    end
    
    def after_login_url
      session.delete(:return_to_after_authenticating) || root_path
    end

    def set_return_to_after_authenticating_via_modal
      if params[:return_to].present?
        session[:return_to_after_authenticating] = params[:return_to]
      end
    end

    def start_new_session_for(user)
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        set_current_session session
      end
    end

    def set_current_session(session)
      Current.session = session
      cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
    end

    def terminate_session
      Current.session&.destroy
      cookies.delete(:session_id)
    end
end
