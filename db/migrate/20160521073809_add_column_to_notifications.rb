class AddColumnToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :activity_type, :string
  end
end
