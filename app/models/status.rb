class Status < ActiveRecord::Base
  # validations
  validates :status, presence: true, length: { minimum: 5 }
  # Associations
  belongs_to :user
  # Attachments
  has_attached_file :statachment, styles: { medium: "508x286>" },
                    url: "/assets/statachments/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/statachments/:id/:style/:basename.:extension"
  validates_attachment_content_type :statachment, { content_type: ["image/jpeg", "image/jpg", "image/gif", "image/png", "application/pdf"] }
  validates_attachment_size :statachment, less_than: 5.megabytes
  # custom validations
  validate :statachment_dimensions
  # Search
  searchable do
    text :status
    integer :id
    integer :user_id
    date :created_at
  end

  def statachment_dimensions
    if self.statachment.present?
      required_width  = 508
      required_height = 286
      dimensions = Paperclip::Geometry.from_file(statachment.queued_for_write[:original].path)
      errors.add(:image, "Width must be #{width}px") unless dimensions.width < required_width
      errors.add(:image, "Height must be #{height}px") unless dimensions.height < required_height
    end
  end
end
