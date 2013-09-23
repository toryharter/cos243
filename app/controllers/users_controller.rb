class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    puts params
    @user = User.new(params[:user])
    render "new"
    @user.save
  end
  
end
