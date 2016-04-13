class AddAttachmentStatachmentToStatuses < ActiveRecord::Migration
  def self.up
    change_table :statuses do |t|
      t.attachment :statachment
    end
  end

  def self.down
    remove_attachment :statuses, :statachment
  end
end
