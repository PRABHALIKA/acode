class ChangeStatusToSubjectInRelations < ActiveRecord::Migration
  def change
    rename_column :relations, :status, :subject
  end
end
