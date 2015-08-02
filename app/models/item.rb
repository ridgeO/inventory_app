class Item < ActiveRecord::Base
  belongs_to :location
  has_many :statuses, dependent: :destroy
  default_scope -> {order(name: :asc)}
  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: {maximum: 50}
  validates :description, length: {maximum:255}
  validate :image_size

  private
  # Validates the size of an uploaded picture
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end

end
