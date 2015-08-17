class Location < ActiveRecord::Base
  has_many :items, dependent: :destroy
  default_scope -> {order(name: :asc)}
  validates :name, presence: true, length: {maximum: 50}

  def self.search(search)
    if search
      where("name LIKE ?", "%#{search}%")
    else
      all
    end
  end

end
