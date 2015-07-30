class Item < ActiveRecord::Base
  default_scope -> {order(name: :asc)}
  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: {maximum: 50}
  validates :description, length: {maximum:255}
  validate :image_size
  validate :future_due
  validate :valid_email

  private
  # Validates the size of an uploaded picture
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end

  # Validates the due date during checkout is in the future
  def future_due
    unless due.nil?
      if due < Time.now
        errors.add(:due, "due date should be in the future")
      end
    end
  end

  # Validates the email used during checkout is valid
  def valid_email
    unless holder.nil?
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      unless holder.match(valid_email_regex)
        errors.add(:holder, "hodler email must be a valid email address")
      end
    end
  end

end
