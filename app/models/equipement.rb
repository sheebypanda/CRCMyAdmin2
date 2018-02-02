class Equipement < ApplicationRecord
  has_one :recette, dependent: :destroy
  validates :serial, presence: true
end
