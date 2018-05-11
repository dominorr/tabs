class Tab < ApplicationRecord
	serialize :chord_positions, Array
	has_and_belongs_to_many :chords
	has_many :ratings

	def likes_percentage
		self.get_likes.size.to_f / self.ratings.size.to_f * 100
	end

	def dislikes_percentage
		self.get_dislikes.size.to_f / self.ratings.size.to_f * 100
	end

	def get_likes
		self.ratings.select{|r| r.value == true}
	end

	def get_dislikes
		self.ratings.select{|r| r.value == false}
	end
end
