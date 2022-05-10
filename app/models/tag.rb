class Tag < ApplicationRecord
	has_and_belongs_to_many :albums
	validates :album_tags, presence: true
end
