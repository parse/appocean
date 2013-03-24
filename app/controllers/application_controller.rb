class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter  :verify_authenticity_token

  before_filter :require_http_auth_user
  helper_method :current_user

  def current_user
  	#p "Current user: " + @current_user.username
    return @current_user if defined?(@current_user)
  end

	def require_http_auth_user
	  authenticate_or_request_with_http_basic do |username, password|
	    if user = User.find_by_username(username) 
	    	if (user.password == password)
	    		@current_user = user
	    		true
	    	else
	    		false
	    	end
	    else
	      false
	    end
	  end
	end

	def log_access
		start_time = Time.now
		yield
		end_time = Time.now
		elapsed = ((end_time-start_time)*1000.0).to_int
		response_data_size = response.body.length
	end

end
