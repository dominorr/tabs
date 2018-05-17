class CreateChordsTabs < ActiveRecord::Migration[5.1]
  def change
    create_table :chord_tabs do |t|
    	t.integer :chord_id, :tab_id
    	t.integer :chord_nr

    	t.timestamps
    end
  end
end
