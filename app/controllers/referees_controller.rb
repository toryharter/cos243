class RefereesController < ApplicationController
   #before_action :ensure_user_logged_in
   
   def new
     @referee = current_user.referees.build
   end 
   
   def create
     @referee = current_user.referees.build(acceptable_params)
     if @referee.save
       flash[:success] = "Referee created"
       redirect_to @referee
     else
       flash[:danger] = "Referee failed to create"
       render "new"
     end
   end 
  
    def show
      @referee = Referee.find(params[:id])
    end
   
   private
     def acceptable_params
       params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
     end
   
     def ensure_user_logged_in
       redirect_to login_path, flash: { :warning => "Unable" } unless logged_in? 
     end
 end