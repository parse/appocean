class RemoveUserIdFromMessages < ActiveRecord::Migration
  def up
  	remove_column :messages, :user_id
  end

  def down
  end
end
