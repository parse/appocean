class RemoveIslandFromMeta < ActiveRecord::Migration
  def up
  	remove_column :user_meta, :island_id
  end

  def down
  end
end
