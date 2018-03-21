class CreateChords < ActiveRecord::Migration[5.1]
  def change
    create_table :chords do |t|
   	  t.string :root
      t.string :chord_type
      t.boolean :barre
      t.string :barre_position

      t.timestamps
    end
  end
end
