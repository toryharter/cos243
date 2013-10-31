class Contest < ActiveRecord::Base
  belongs_to :referee
  belongs_to :user
  has_many :players
  has_many :matches, as: :manager
  validates :user, presence: true
  validates :referee, presence: true
end
