class Profile < ApplicationRecord
	belongs_to :user

	validates :city, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
    validates :country, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
    validates :biography, length: { maximum: 500 }
end
