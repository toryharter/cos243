class Referee < ActiveRecord::Base
  belongs_to :user
  has_many :contests
  has_many :matches, as: :manager
  
  REGEX=/(http(?:s)?\:\/\/[a-zA-Z0-9\-]+(?:\.[a-zA-Z0-9\-]+)*\.[a-zA-Z]{2,6}(?:\/?|(?:\/[\w\-]+)*)(?:\/?|\/\w+\.[a-zA-Z]{2,4}(?:\?[\w]+\=[\w\-]+)?)?(?:\&[\w]+\=[\w\-]+)*)/
  validates :players_per_game, presence: true, :numericality => { greater_than_or_equal_to: 1, less_than_or_equal_to: 10, only_integer: true }
  validates :name, length: { minimum: 2 }, uniqueness: true  
  validates :rules_url, presence: true, :format => {with: REGEX} 
  validate :check_file
    
  include Uploadable
    
  before_destroy :delete_file
  
  def delete_file
    File.delete(self.file_location)
  end
    
  def referee
    self
  end
    
  def check_file
    if self.file_location && !File.exists?(self.file_location)
      errors.add(:file_location, "is an invalid file location!")
    end
  end
end