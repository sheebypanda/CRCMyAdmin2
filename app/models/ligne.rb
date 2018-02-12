class Ligne < ApplicationRecord
  belongs_to :operateur
  has_many :recettes
  has_many :equipements, through: :recettes
  has_one :localisation, through: :recettes
  validates :numerocompte, presence: true, uniqueness: true

end
