class AddPositionsAndFingeringToChords < ActiveRecord::Migration[5.1]
  def change
  	add_column :chords, :positions, :string
  	add_column :chords, :fingering, :string
  end
end
