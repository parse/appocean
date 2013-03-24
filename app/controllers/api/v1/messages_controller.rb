class Api::V1::MessagesController < ApplicationController
	
	# Fetch all messages to a specific user
	def index
		@user = @current_user
    @messages = @user.received_messages
    respond_to do |format|
      format.json { render json: @messages }
    end
	end
end
