class RemoveUserFromMessages < ActiveRecord::Migration
  def up
  	remove_column :messages, :user_id_from
  	remove_column :messages, :user_id_to
  end

  def down
  end
end
