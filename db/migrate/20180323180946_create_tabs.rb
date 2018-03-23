class CreateTabs < ActiveRecord::Migration[5.1]
  def change
    create_table :tabs do |t|
    	t.string :title
    	t.string :scale
    	t.string :author
    	t.string :genre
    	t.text :lyrics
    	t.string :chord_positions

      t.timestamps
    end
  end
end
