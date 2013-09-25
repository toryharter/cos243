class UsersController < ApplicationController
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
  
end
