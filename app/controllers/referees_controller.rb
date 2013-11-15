class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update]
   
   def new
       @referee = current_user.referees.build
   end 
   
   def create
     @referee = current_user.referees.build(acceptable_params)
     if @referee.save then
       flash[:success] = "Referee created"
       redirect_to @referee
     else
       flash[:danger] = "Referee failed to create"
       render "new"
     end
   end
  
  def edit
    @referee = Referee.find(params[:id])
  end
  
  def update
    @referee = Referee.find(params[:id])
    if @referee.update_attributes(acceptable_params) then
      flash[:success] = "Referee updated"
      redirect_to @referee
    else
      render 'edit'
    end
  end
  
  def index
    @referees = Referee.all
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
  
  def destroy
    @referee = Referee.find(params[:id])
    if @referee.destroy then
      flash[:success] = "Referee destroyed."
      redirect_to referees_path
    else
      flash[:danger] = "Referee was not deleted"
      redirect_to root_path
    end 
  end
   
   private
     def acceptable_params
       params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
     end
   
     def ensure_user_logged_in
       redirect_to login_path, flash: { :warning => "Unable" } unless logged_in? 
     end
 end