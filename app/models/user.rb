 	 
class User < ActiveRecord::Base
require 'bcrypt'

	has_secure_password
	has_many	:posts
	has_many 	:comments, through: :posts
	validates :email, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: /\w+@\w+\.\w+/}
	validates :password_digest, presence: true
	
	# validates :email, format: { with: /.*@.*\..*/, message: "invalid email format" }
	# validates	:password_digest, presence: true


end
