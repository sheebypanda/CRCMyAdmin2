class Livraison < ApplicationRecord
  belongs_to :user
  has_many :equipements
  has_many_attached :pvs
  validates :nom, uniqueness: true
end
