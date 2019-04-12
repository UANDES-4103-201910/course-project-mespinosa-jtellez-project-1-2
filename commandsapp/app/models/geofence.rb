class Geofence < ApplicationRecord
	has_many :administrator

	validates :location, presence: true
	validates :location, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
end
