class Relation < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  # custom validations
  validate :relativity
  # Search
  searchable do
    integer :user_id
    integer :friend_id
    date :created_at
    integer :subject
  end

  def relativity
    if self.user_id == self.friend_id
      errors.add :base, 'Invalid Request'
    end
  end
end
