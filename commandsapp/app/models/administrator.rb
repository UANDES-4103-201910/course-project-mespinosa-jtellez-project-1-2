class Administrator < ApplicationRecord
	belongs_to :geofence
	belongs_to :user

end
