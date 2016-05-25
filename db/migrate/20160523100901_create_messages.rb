class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.integer :recipient_id
      t.boolean :seen, default: false
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :messages, :users
  end
end
