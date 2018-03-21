class Chord < ApplicationRecord
	serialize :positions, Array
	serialize :fingering, Array
end
