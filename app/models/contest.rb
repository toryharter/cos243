class Contest < ActiveRecord::Base
  belongs_to :referee
  belongs_to :user
  has_many :players
  has_many :matches, as: :manager
  
  validates :referee, presence: true
  validates :user, presence: true
  validates :name, length: { minimum: 2 }, uniqueness: true  
  validates :contest_type, presence: true
  validates :start, presence: true
  validates :deadline, presence: true
  validates :description, presence: true
  
  validates :start, presence: true, :timeliness => {:on_or_after => :now, :type => :datetime}
  validates :deadline, presence: true, :timeliness => {:on_or_after => :now, :type => :datetime, :on_or_before => lambda { |record| record.start } }
  
end