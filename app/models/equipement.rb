class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  validates :nom, presence: true
end
