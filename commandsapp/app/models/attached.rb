class Attached < ApplicationRecord
	belongs_to :post

	validates :name, presence: true, length: {minimum: 1}
end
