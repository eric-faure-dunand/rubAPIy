class Team < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :city, presence: true

  has_many :players, class_name: "player", foreign_key: "reference_id"
end
