class Contest < ActiveRecord::Base
  belongs_to :referee
  belongs_to :user
  has_many :players
  has_many :matches, as: :manager
  
  validates_datetime :deadline, :on_or_after => lambda { Time.now.change(:usec => 0) }
  validates_datetime :start, :on_or_after => lambda { :deadline }
  
  validates :referee, presence: true
  validates :user, presence: true
  validates :name, length: { minimum: 2 }, uniqueness: true  
  validates :contest_type, presence: true
  validates :start, presence: true
  validates :deadline, presence: true
  validates :description, presence: true
end