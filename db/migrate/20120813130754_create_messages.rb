class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.integer :user_id_from 
    	t.integer :user_id_to
    	t.text :message
    	t.references :user
      t.timestamps
    end
  end
end
