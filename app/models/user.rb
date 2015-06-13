class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 } 

	has_secure_password
end
