class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email params[:session][:email]
  	if user && user.valid_password?(params[:session][:password])
  		session[:user_id] = user.id
  		redirect_to user
  	else
  		puts "NOOOOOO!!!!"
	  	render 'new'
	end
  end

  def destroy

  end
end