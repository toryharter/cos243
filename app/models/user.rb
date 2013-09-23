class User < ActiveRecord::Base
  has_secure_password
  validates :usersname, presence: true
end