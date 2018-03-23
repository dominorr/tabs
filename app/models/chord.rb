class Chord < ApplicationRecord
	serialize :positions, Array
	serialize :fingering, Array
	has_and_belongs_to_many :tabs
end
