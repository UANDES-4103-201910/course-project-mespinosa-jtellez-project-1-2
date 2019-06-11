class Post < ApplicationRecord
	belongs_to :user
	has_many :flag
	has_many :comment
	has_many :vote
	has_many :follow
	has_many :tag
	has_many :image
	has_many :attached
	has_many :link
	has_one :dumpster

	acts_as_mappable   :default_units => :kms,
	                   :default_formula => :sphere,
	                   :distance_field_name => :distance,
	                   :lat_column_name => :latitude,
	                   :lng_column_name => :longitude

	mount_uploader :avatar, AvatarUploader
	mount_uploader :image, ImageUploader

	validates :title, length: { minimum: 2 }, presence: true
    validates :description, length: { maximum: 500 }, presence: true

end
