class Livraison < ApplicationRecord
  belongs_to :user
  has_many :equipements
  has_many_attached :pvs
  validates :nom, presence: true, uniqueness: true
  validates :commande, presence: true
end
