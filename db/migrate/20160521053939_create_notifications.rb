class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :activity_id
      t.references :user, index: true
      t.integer :recipient_id
      t.boolean :seen

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
