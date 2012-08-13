class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter  :verify_authenticity_token

	def require_http_auth_user
	  authenticate_or_request_with_http_basic do |username, password|
	    if user = User.find_by_username(username) 
	    	if (user.password == password)
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
