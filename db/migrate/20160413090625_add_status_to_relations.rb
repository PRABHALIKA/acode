class AddStatusToRelations < ActiveRecord::Migration
  def change
    add_column :relations, :status, :string
  end
end
