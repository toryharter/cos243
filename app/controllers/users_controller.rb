class UsersController < ApplicationController
  before_action :ensure_user_logged_in, only: [:edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_admin_user, only: [:destroy]
  before_action :ensure_not_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save then
      log_in(@user)
      flash[:success] = "User #{@user.username} has been created"
      redirect_to @user     
    else
      render 'new'
    end
  end
    
  def edit
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User " + @user.username + " updated successfully!"
      redirect_to @user
    else
      render 'edit'
    end
  end
    
  def index
    @users = User.all
  end
    
  def show
    @user = User.find(params[:id])
  end
    
  def destroy
    @user = User.find(params[:id])
    if !current_user?(@user)
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_path
    else
      flash[:danger] = "Unable to delete user!"
      redirect_to root_path
    end 
  end 
    
  private
    def ensure_admin_user
      redirect_to root_path, flash: { :danger => "Admin permissions required" } unless current_user.admin?
    end 
    
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to root_path, flash: { :danger => "Unable to edit page!" } unless current_user?(@user)
    end
    
    def ensure_not_logged_in
      redirect_to root_path, flash: { :warning => "Unable to perform action!" } unless !logged_in?
    end 
    
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end