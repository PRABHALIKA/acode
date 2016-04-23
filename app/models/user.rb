class User < ActiveRecord::Base
  #include dobxcheck
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Validations
  validates :first_name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :gender, presence: true, inclusion: { in: [Constants::MALE, Constants::FEMALE] }
  validates :email, presence: true
  validates :about_me, presence: true, length: { maximum: 512 }, allow_blank: true
  validates :dob, presence: true
  # Custom validations
  validate :date_of_birth
  # Associations
  has_many :statuses, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :friends, through: :relations, dependent: :destroy
  # Attachments
  has_attached_file :avatar, styles: { normal: '50x50#', profile: '100x100#'},
                    default_url: "users/:style/missingdp.jpeg",
                    url: "/assets/users/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assets/users/:id/:style/:basename.:extension"
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  # Gives the full name of user
  def full_name
    return self.first_name.to_s.humanize + " " + self.last_name.to_s.humanize if self
  end

  # Gives the  initial of user first name
  def self.initial
    self.first_name[0,1] if self
  end

  # Return true if current_user and friend are friends
  def friend?(current_user,friend)
    (friend && 
    Relation.where(user_id: current_user.id, friend_id: friend, subject: Constants::Subject::MAKE).present?) ? true : false
  end

  def date_of_birth
    dob = self.dob
    sep1 = dob[2,1].to_s
    sep2 = dob[5,1].to_s
    if (dob.length == 10) && (sep1 == '/' && sep2 == '/') 
      day  = dob[0,2].to_i if day.to_i.is_a? Numeric
      mon  = dob[3,2].to_i if mon.to_i.is_a? Numeric
      year = dob[6,4].to_i if year.to_i.is_a? Numeric
      if (mon < 1 || mon > 12)
        errors.add :base, 'Enter correct month'
      else
        if (year <= 1900) || (year >= (Date.today.year - 10))
          errors.add :base, 'Enter valid year, minimum age should be 10 years'
        else
          validate_days mon, day
        end
      end
    else
      errors.add :base, 'Enter date in valid format'
    end
  end

  def validate_days(mon, days)
    case mon
    when 1 || 3 || 5 || 7 || 8 || 10 || 12
      month_days days, 31
    when 02
      if Date.leap year
        month_days days, 29
      else
        month_days days, 28
      end
    when 4 || 6 || 9 || 11
      month_days days, 30
    end
  end

  def month_days(days, month_days)
    if (days < 1) || (days > month_days)
      errors.add :base, "Enter correct day"
    end
  end
end
