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
end
