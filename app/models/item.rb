class Item < ActiveRecord::Base
  belongs_to :location
  has_many :statuses, dependent: :destroy
  default_scope -> {order(name: :asc)}
  mount_uploader :image, PictureUploader
  validates :name, presence: true, length: {maximum: 50}
  validates :description, length: {maximum:255}
  validate :image_size

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @item = Item.create! row.to_hash
      Status.create!(item_id: @item.id, name: "In", holder: nil, due: nil)
    end
  end

  def self.search(search)
    if search
      where("name LIKE ?", "%#{search}%")
    else
      all
    end
  end

  private
  # Validates the size of an uploaded picture
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end

end
