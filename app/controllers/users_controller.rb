class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    permittedparams = params.require(:user).permit(:username,:password,:password_confirmation,:email)
    @user = User.new(permittedparams)
    
    if @user.save then
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
  end
    
  def update
    #permittedparams = params.require(:user).permit(:username,:password,:password_confirmation,:email)
    @user = User.find(params[:id])
    @user.update_attributes(username: params[:user][:username], email: params[:user][:email])
    
    if @user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

    
end