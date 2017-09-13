class User < ApplicationRecord

	has_many :books
	
	has_secure_password

	validates :username, presence: true	
	validates :username, uniqueness: true
	validates :password, length: {minimum: 8}
end
