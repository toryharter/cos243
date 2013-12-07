class Match < ActiveRecord::Base
  belongs_to :contest
  belongs_to :referee
  belongs_to :manager, polymorphic: true
  has_many :player_matches
  has_many :players, through: :player_matches
  validates :manager, presence: true  
  validates :status, presence: true
  validate :num_players
  
  validates_date :completion, :on_or_before => lambda { Date.current }, :if => :checkfuturedate
  validates_datetime :earliest_start, :if => :checktime
  
  def num_players
    if self.players && self.manager
      if self.players.count != self.manager.referee.players_per_game
        errors.add(:manager, "Invalid number of players!")
      end 
    end 
  end
  
  def checkfuturedate
    if self.status != "Completed"
      return nil
    else
      return true
    end
  end
  
  def checktime
    if self.status == "Completed"
      return nil
    elsif self.status == "Started"
      return nil
    else
      return true
    end
  end
end