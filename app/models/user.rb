class User < ActiveRecord::Base
  attr_accessor :username, :email, :password
  has_secure_password
end