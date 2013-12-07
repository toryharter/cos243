class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      flash[:success] = "#{@user.username} is logged in!"
      redirect_to @user  
    else
      flash.now[:danger] = "Invalid username or password!"
      render 'new'
    end
  end
  
  def destroy
    cookies.delete :user_id
    flash[:info] = "You are now logged out!"
    redirect_to login_path
  end
end