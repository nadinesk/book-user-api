class User < ApplicationRecord

	has_many :books
	
	has_secure_password

	validates :email, presence: true	
	validates :email, uniqueness: true
	validates :password, length: {minimum: 8}
end
