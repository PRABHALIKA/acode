class AddSubjectToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :subject, :string
  end
end
