# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Chord.create(root: 'C', chord_type: 'major', barre: false, positions: [0,3,2,0,1,0], fingering: [0,3,2,0,1,0])
Chord.create(root: 'E', chord_type: 'major', barre: false, positions: [0,2,2,1,0,0], fingering: [0,2,3,1,0,0])
Chord.create(root: 'A', chord_type: 'minor', barre: false, positions: [0,0,2,2,1,0], fingering: [0,0,2,3,1,0])
Chord.create(root: 'G', chord_type: 'major', barre: false, positions: [3,2,0,0,0,3], fingering: [3,2,0,0,0,4])
Chord.create(root: 'F', chord_type: 'major', barre: false, positions: [1,3,3,2,1,1], fingering: [1,3,4,2,1,1])