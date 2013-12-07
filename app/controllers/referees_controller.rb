class RefereesController < ApplicationController
  before_action :ensure_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_contest_creator, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def new
    @referee = current_user.referees.build
  end 
  
  def create
    @referee = current_user.referees.build(acceptable_params)
    if @referee.save then
      flash[:success] = "Referee created"
      redirect_to @referee     
    else
      render 'new'
    end
  end
  
  def index
    @referees = Referee.all
  end
  
  def show
    @referee = Referee.find(params[:id])
  end
  
  def update
    if @referee.update_attributes(acceptable_params)
      flash[:success] = "Referee #{@referee.name} has been updated successfully!"
      redirect_to @referee
    else
      render 'edit'
    end
  end
  
  def edit
  end
  
  def destroy
    @referee = Referee.find(params[:id])
    if current_user?(@referee.user) #|| current_user.admin?
      @referee.destroy
      flash[:success] = "Referee deleted."
      redirect_to referees_path
    else
      flash[:danger] = "Unable to delete referee."
      redirect_to root_path
    end 
  end
  
  private
    def acceptable_params
      params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
    end
    
    def ensure_correct_user
      @referee = Referee.find(params[:id])
      redirect_to login_path, flash: { :danger => "Login of correct user required!" } unless current_user?(@referee.user)
    end 
   
    def ensure_user_logged_in
      redirect_to login_path, flash: { :warning => "Login required!" } unless logged_in? 
    end
    
    def ensure_contest_creator 
      redirect_to root_path, flash: { :danger => "Must be contest creator!" } unless current_user.contest_creator?
    end
end