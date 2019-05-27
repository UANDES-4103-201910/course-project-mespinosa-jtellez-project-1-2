class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:google_oauth2]
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

	def self.from_omniauth(auth)
		where(provider: auth.provider ,uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
			user.name = auth.info.name
			user.password = Devise.friendly_token[0, 20]
		end
	end

end
