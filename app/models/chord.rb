class Chord < ApplicationRecord
	serialize :positions, Array
	serialize :fingering, Array

	has_many :chord_tabs
	has_many :tabs, through: :chord_tabs
end
