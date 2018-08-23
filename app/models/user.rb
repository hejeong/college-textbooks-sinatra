class User < ActiveRecord::Base
  has_many :textbooks
  has_secure_password
end
