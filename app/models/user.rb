class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :name, presence: true, length: {minimum: 6, maximum: 50}
	validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 6, maximum: 255}, format: {with: VALID_EMAIL_REGEX }
	before_save {email.downcase!}
	has_secure_password
end
