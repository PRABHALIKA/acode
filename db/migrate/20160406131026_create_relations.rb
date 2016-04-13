class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.references :user, index: true
      t.references :friend, index: true

      t.timestamps null: false
    end
    add_foreign_key :relations, :users
    add_foreign_key :relations, :friends
  end
end
