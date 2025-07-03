class Player < ApplicationRecord
  attr_accessor :team
  belongs_to :team, optional: true
  validates :name, presence: true, uniqueness: true
  validates :post, presence: true
end
