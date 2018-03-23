class Tab < ApplicationRecord
	serialize :chord_positions, Array
	has_and_belongs_to_many :chords
end
