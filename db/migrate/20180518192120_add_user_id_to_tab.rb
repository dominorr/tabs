class AddUserIdToTab < ActiveRecord::Migration[5.1]
  def change
  	add_column :tabs, :user_id, :integer
  end
end
