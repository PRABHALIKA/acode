class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :status
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :statuses, :users
  end
end
