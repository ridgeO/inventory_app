class Status < ActiveRecord::Base
  belongs_to :item
  validates :name, presence: true
  validate :valid_email
  validate :future_due
  validate :future_start

  private

  # Validates the due date during checkout is in the future
  def future_due
    unless name == "In" or !due.nil?
      errors.add(:due, "please enter a due date")
    else
      unless due.nil?
        if due < Time.now
          errors.add(:due, "due date should be in the future")
        end
      end
    end
  end

  # Validates the start_time used during checkout is not in the past
  def future_start
    unless start_time >= Date.today
      errors.add(:start_time, "request start date must be in the future")
    end
  end

  # Validates the email used during checkout is valid
  def valid_email
    unless holder.nil? && due.nil?
    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      unless holder.match(valid_email_regex)
        errors.add(:holder, "holder email must be a valid email address")
      end
    end
  end

end
