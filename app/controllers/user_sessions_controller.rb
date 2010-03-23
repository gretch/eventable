class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end
  
  def create
      user = User.find_by_email(params[:user_session][:email])
      user_pass = user.nil? ? false : user.password_salt==params[:user_session][:password]
      @user_session = UserSession.new(user, true)

      if user_pass and @user_session.save
        flash[:notice] = "Login successful."
        redirect_to root_path
      else
        flash[:notice] = "We couldn't authenticate you. Kindly check your credentials. Have you signup yet?"
        render :action => :new
      end
  end
  
  def destroy
    if current_user_session
  	  current_user_session.destroy rescue nil
      flash[:notice] = "Successfully logout!"
    else
			flash[:notice] = "You are already logged out."
    end
    redirect_to root_path
  end
  
end
