class User < ApplicationRecord
	has_one :user
	has_one :profile
	has_one :blacklist
	has_many :flag
	has_many :post
	has_many :comment
	has_many :vote
	has_many :follow
	has_many :tag

	validates :name, presence: true, length: {in: 3..20}
	validates :password, confirmation: true, length: {minimum: 8}, presence: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, confirmation: true

end
