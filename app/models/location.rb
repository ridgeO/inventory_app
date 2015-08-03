class Location < ActiveRecord::Base
  has_many :items, dependent: :destroy
  default_scope -> {order(name: :asc)}
end
