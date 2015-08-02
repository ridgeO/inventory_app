class Status < ActiveRecord::Base
  belongs_to :item
  validates :name, presence: true
  validate :future_due
  validate :valid_email

  private

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
    unless holder.nil? && due.nil?
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      unless holder.match(valid_email_regex)
        errors.add(:holder, "hodler email must be a valid email address")
      end
    end
  end

end
