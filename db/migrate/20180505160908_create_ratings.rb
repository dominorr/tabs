class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
    	t.boolean :value
    	t.references :user
    	t.references :tab

      t.timestamps
    end
  end
end
