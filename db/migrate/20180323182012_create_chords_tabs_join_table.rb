class CreateChordsTabsJoinTable < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :chords, :tabs
  end
end
