class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      log_in(@user)
      flash[:success] = "#{@user.username} logged in!"
      redirect_to @user  
    else
      flash.now[:danger] = "Invalid username or password! (Probably a hacker, right?)"
      render 'new'
    end
  end
  
  def destroy
    cookies.delete :user_id
    flash[:info] = "Logged Out!"
    redirect_to login_path
  end
  
end