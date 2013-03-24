class Api::V1::UsersController < ApplicationController 
	#before_filter :require_http_auth_user, :except => [:create, :show]
  skip_before_filter :require_http_auth_user, :except => [:login, :show]

  # Login users
  def login
	  response = { "status" => "ok", "message" => "Successfully logged in." }
		render :json => response.to_json, :status => :ok
	end

	# GET /users/x.json
	# GET /users/x/
  def show
    @user = User.find_by_username(params[:id])
   # @meta = @user.UserMeta.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # CREATE /users
	def create
  	@user = User.find_by_username(params[:username])

  	if (@user)
  		response = { "status" => "error", "message" => "User already exists" }
  		render :json => response.to_json, :status => :forbidden
  	else
  		# Save user
			@user = User.new(:username => params[:username], :password => params[:password])
			@user.save!

			# Loop through meta data
			params[:meta].each_with_index do |key, value|
				m = UserMeta.new
				m.user = @user
				m.key = key
				m.value = value
				
				m.save!
			end

			response = { "status" => "ok", "message" => "Successfully registered user." }
			render :json => response.to_json, :status => :created
  	end
  end

  def destroy
    @user = User.find_by_username(params[:username])
    
    if @user.destroy
      response = { "status" => "ok", "message" => "Successfully deleted user." }
      render :json => response.to_json, :status => :created
    else
      response = { "status" => "error", "message" => "Could not delete user" }
      render :json => response.to_json, :status => :forbidden
    end
  end

  def index
    @users = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
