class AddIndexToRelations < ActiveRecord::Migration
  def change
    add_index :relations, [:friend_id, :user_id], unique: true
  end
end
